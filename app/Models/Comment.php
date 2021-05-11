<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
class Comment extends Model
{

    protected $table = 'comment';

    protected $fillable = ['content','user_id', 'comment_date', 'post_id', 'comment_id'];

    //associations with comment, post, user, voteComment, Report, Notification

    /**
     * Get the post associated with the Comment
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function post(): HasOne
    {
        return $this->belongsTo(Post::class, 'post_id');
    }

    /**
     * Get the user associated with the Comment
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function user(): HasOne
    {
        return $this->belongsTo(AuthenticatedUser::class, 'user_id');
    }
    
    public function voted_by(){
        return $this->belongsToMany(AuthenticatedUser::class,"vote_comment","user_id","comment_id")->withPivot("like");
    }

    public function owner(){
        return $this->hasOne(Post::class);
    }

    public function comment_threads(){
        return $this->hasMany(Comment::class);
    }

    public function parent_comment(){
        return $this->hasOne(Comment::class,"comment_id");
    }

    public static function getPostComments($post_id,$date_order){
        $comments = Comment::where("post_id",$post_id)->orderBy("comment_date",$date_order)->get();
        $result = array();
        foreach($comments as $comment){
            $temp = Comment::getCommentInfo($comment->id);
            $result[] = $temp;
        }
        return $result;
    }

    public static function getPostPopularComments($post_id){
        $comments = DB::select(DB::raw("SELECT C.content as c_content,C.id as c_id,C.user_id as c_user_id,C.post_id as c_post_id,C.comment_id as c_comment_id ,
                SUM(CASE WHEN R.like THEN 1 ELSE 0 END) AS overallRating
            FROM comment C
            LEFT JOIN vote_comment  R ON R.comment_id = C.id
            WHERE C.post_id = $post_id
            GROUP BY C.id
            ORDER BY overallRating desc;"));

        $comment_ids = array();
        foreach($comments as  $comment){
            $comment_ids[] = $comment->c_id;
        }
        
        $result = array();
        foreach($comment_ids as $id){
            $temp = Comment::getCommentInfo($id);
            $result[] = $temp;
        }
        return $result;
    }

    public static function getCommentThreads($comment_id){
        $comments = Comment::where("comment_id",$comment_id)->orderBy("comment_date","desc")->get();
        $result = array();
        foreach($comments as $comment){
            $temp = Comment::getThreadInfo($comment->id);
            $result[] = $temp;
        }
        return $result;
    }


    public static function getCommentInfo($comment_id){
        $comment = Comment::find($comment_id);
        $votes = DB::table("vote_comment")->where("comment_id",$comment->id);
        $temp = $votes->get()->count();
        $likes = $votes->where("like",true)->get()->count();
        $dislikes = $temp - $likes;
        $threads = Comment::getCommentThreads($comment->id);
        $temp_array = array();
        $temp_array["comment"] = $comment;
        $temp_array["likes"] = $likes;
        $temp_array["dislikes"] = $dislikes;
        $temp_array["date"] = date("F j, Y", strtotime($comment['comment_date']));
        $temp_array["author"] = AuthenticatedUser::find($comment->user_id)->name;
        $temp_array["threads"] = $threads;
        $temp_array["thread_count"] = count($threads);
        return $temp_array;
    }

    public static function getThreadInfo($thread_id){
        $result = Comment::getCommentInfo($thread_id);
        unset($result["threads"]);
        unset($result["thread_count"]);
        return $result;
    }

    public static function commentsAsHtml($comments,$user_id){
        $result = "";
        foreach($comments as $comment){
            $comment_route = request()->getSchemeAndHttpHost() .'/user/' . $comment['comment']->user_id;
            $result = $result . 
            "<span class=\"comment-container\">
            <div class=\"row justify-content-center px-4 mx-1\">
            <div class=\"col-10 post-page-comment pt-3 pb-2 px-3 mt-2 show-hide-replies\" style=\"cursor:pointer\">
                <div class=\"row px-2 py-0\">
                    <div class=\"col-auto p-0 m-0\">
                        <h3 class=\"post-page-comment-body m-0\">". nl2br(htmlspecialchars($comment['comment']->content)). "</h3>
                    </div>    
                        <div class=\"col-auto p-0 m-0 ms-auto\">
                            <span class=\"comment_id\" hidden>" . nl2br(htmlspecialchars($comment['comment']->id)) . "</span>" .
                            
                            ($user_id==$comment['comment']->user_id?
                            "<div class=\"dropdown\">
                                <a class=\"btn fa-cog-icon\"  style=\"font-size:30%;\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">
                                    <i class=\"fas fa-cog ms-auto\" style=\"font-size:3em;\"></i>
                                </a>
                                <ul class=\"dropdown-menu dropdown-menu-end\">
                                    <a class=\"dropdown-item edit_comment_button\">Edit Comment</a>
                                    <li>
                                        <hr class=\"dropdown-divider\">
                                    </li>
                                    <a class=\"dropdown-item delete_comment_button\" >Delete Comment</a>
                                </ul>
                            </div>":"")

                            .

                        "</div>
                    </div>
            
                <div class=\"row align-items-end px-2 py-1\">
                    <div class=\"col-lg-auto col-12 px-0 py-1 m-0 align-self-end\">
                        <h3 class=\"post-page-comment-author-date p-0 m-0\">by <a href=\"" .$comment_route . "\">" . nl2br(htmlspecialchars($comment['author'])) . "</a>, " .  nl2br(htmlspecialchars($comment['date'])) . "</h3>
                    </div>
                    <div class=\"col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto\">
                        <div class=\"row\">
                            <div class=\"d-flex\">
                                <h3 class=\"post-page-comment-interactions pe-3 my-0\">" .nl2br(htmlspecialchars( $comment['likes'])) . " <i title=\"Like comment\" class=\"far fa-thumbs-up\"></i></h3>
                                <h3 class=\"post-page-comment-interactions pe-3 my-0\">" . nl2br(htmlspecialchars($comment['dislikes'])) . " <i title=\"Dislike comment\" class=\"far fa-thumbs-down\"></i></h3>
                                <i title=\"Report comment\" class=\"fas fa-ban my-0 pe-3 post-page-report-comment\"></i>
                                <h3 class=\"post-page-comment-interactions my-0\">" . nl2br(htmlspecialchars($comment['thread_count'])) . " <i class=\"far fa-comments\"></i></h3>
                                <h3 class=\"post-page-comment-interactions pe-3 my-0 show-hide-replies\" style=\"white-space:pre;\">    <i style=\"color:black;\"title=\"Show/Hide replies\" class=\"fas fa-chevron-down\"></i></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>\n";
        foreach($comment['threads'] as $thread){
            $thread_route = request()->getSchemeAndHttpHost() .'/user/' . $thread['comment']->user_id;
            $result = $result . "<span  class=\"thread-container\"><div class=\"row justify-content-center px-4 mx-1 thread-section\">
            <div class=\"col-10 mx-0 px-0\">
                <div class=\"row justify-content-end comment-replies mx-0 px-0\">
                    <div class=\"col-11 post-page-comment-reply reply py-2 pt-2 pb-1 mt-1\">
                        <div class=\"row px-2 py-0\">
                            <div class=\"col-auto p-0 m-0\">
                                <h3 class=\"post-page-comment-reply-body m-0\">" . nl2br(htmlspecialchars($thread['comment']->content)) . "</h3>
                            </div>" ."<div class=\"col-auto p-0 m-0 ms-auto\">".
                            "<span class=\"comment_id THREADID\" hidden>{$thread['comment']->id}</span>
                            <span class=\"parent_id\" hidden>{$comment['comment']->id}</span>".
                            ($user_id==$thread['comment']->user_id?
                            "<div class=\"dropdown\">
                            <a class=\"btn fa-cog-icon\"  style=\"font-size:30%;\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">
                                <i class=\"fas fa-cog ms-auto\" style=\"font-size:3em;\"></i>
                            </a>
                            <ul class=\"dropdown-menu dropdown-menu-end\">
                                <a class=\"dropdown-item edit_comment_button\">Edit Comment</a>
                                <li>
                                    <hr class=\"dropdown-divider\">
                                </li>
                                <a class=\"dropdown-item delete_comment_button\" >Delete Comment</a>
                            </ul>
                        </div>":"").

                        "</div></div>
                        <div class=\"row align-items-end px-2 py-0\">
                            <div class=\"col-lg-auto col-12 px-0 py-1 m-0 align-self-end\">
                                <h3 class=\"post-page-comment-reply-author-date p-0 m-0\">by <a href=\"".$thread_route ."\">" . nl2br(htmlspecialchars($thread['author'])) . "</a>, " . nl2br(htmlspecialchars($thread['date'])) . "</h3>
                            </div>
                            <div class=\"col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto\">
                                <div class=\"row\">
                                    <div class=\"d-flex\">
                                        <h3 class=\"post-page-comment-interactions pe-3 my-0\">" . nl2br(htmlspecialchars($thread['likes'])) . " <i title=\"Like comment\" class=\"far fa-thumbs-up\"></i></h3>
                                        <h3 class=\"post-page-comment-interactions pe-3 my-0\">" . nl2br(htmlspecialchars($thread['dislikes'])) . " <i title=\"Dislike comment\" class=\"far fa-thumbs-down\"></i></h3>
                                        <i title=\"Report comment\" class=\"fas fa-ban my-0 post-page-report-comment\"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div></span>";
        }
        $result = $result . ($user_id!=0?"<div class=\"row justify-content-center px-4 mx-1 thread-reply\">
            <div class=\"col-10 mx-0 px-0\">
                <div class=\"row justify-content-end comment-replies mx-0 px-0\">
                    <div class=\"col-11 post-page-comment-reply-editor px-0 mx-0 mt-1\">
                        <div class=\"row px-0 mx-0\">
                            <div class=\"d-flex mx-0 px-0\">
                                    <textarea class=\"container form-control post-page-add-comment-reply w-100 add-thread\" id=\"add-comment\" rows=\"1\"
                                              placeholder=\"Answer in thread\"></textarea>
                            </div>
                        </div>
                        <div class=\"row px-0 mx-0 justify-content-end\">
                            <div class=\"col-auto px-0\">
                                <span class=\"thread_comment_id\" hidden>" . nl2br(htmlspecialchars($comment['comment']->id)) ."</span>
                                <button class=\"post-page-comment-button btn m-0 mt-1 add_thread_button\">Comment</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </span>\n":"");
        
        
    }
        return $result;
    }
}
