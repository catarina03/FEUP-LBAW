<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Photo;
use App\Models\Tag;
use App\Models\AuthenticatedUser;
use App\Models\Comment;
use App\Policies\PostPolicy;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;

class CommentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        DB::table(report)->select()->get();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request,$post_id)
    {
        $validatedData = $request->validate([
            'content' => 'required|max:255',
            'user_id' => 'required|numeric',
            'post_id' => 'required|numeric'
        ]);
        if(Auth::check()){
            $post = Post::find($validatedData['post_id']);
            if($post != null && Auth::user()->id != $post->user_id){
                DB::table('comment')->insert([
                    'content' => $validatedData['content'],
                    'user_id' => $validatedData['user_id'],
                    'post_id' => $validatedData['post_id']
                ]);
                $comments = CommentController::getPostComments($post_id);
                return CommentController::commentsAsHtml($comments);
            }
        }
        return "";
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function show(Comment $comment)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function edit(Comment $comment)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Comment $comment)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Comment  $comment
     * @return \Illuminate\Http\Response
     */
    public function destroy(Comment $comment)
    {
        $comment->delete();
    }

    public function addComment(Request $request,$post_id){//store?
        
    }

    public function editAction(Request $request,$comment_id){//update?
        $validatedData = $request->validate([
            'content' => 'required|max:255',
            'comment_id' => 'required|numeric'
        ]);
        DB::table('comment')->where('id',$comment_id)->update(['content' => $validatedData['content']]); 
    }


    public function destroyComment(Request $request,$comment_id){
        $comment = Comment::find($comment_id);
        destroy($comment);
    }

    public function threads(Request $request,$comment_id){
        $threads = DB::table('comment')->where('comment_id',$comment_id)->select('id','content','comment_date','user_id','post_id','comment_id')->get();
    }

    public function addThread(Request $request,$comment_id){
        $validatedData = $request->validate([
            'content' => 'required|max:255',
            'user_id' => 'required|numeric',
            'comment_id' => 'required|numeric'
        ]);
        if(Auth::check()){
            $comment = Comment::find($validatedData['comment_id']);
            if($comment != null && Auth::user()->id == $validatedData['user_id']){
                DB::table('comment')->insert([
                    'content' => $validatedData['content'],
                    'user_id' => $validatedData['user_id'],
                    'comment_id' => $validatedData['comment_id']
                ]);
                $comments = CommentController::getPostComments($comment->post_id);
                return CommentController::commentsAsHtml($comments);
            }
        }
        return "";

    }

    public function reportComment(Request $request,$comment_id){
        $validatedData = $request->validate([
            'motive' => 'required',
            'user_reporting' => 'required|numeric',
            'comment_reported' => 'required|numeric'
        ]);

        DB::table('report')->insert([
            'reported_date' => 'DEFAULT',
            'accepted' => 'NULL',
            'closed_date' => 'NULL',
            'motive' => $validatedData->motive,
            'user_reporting' => $validatedData->user_reporting,
            'user_assigned' => 'NULL',
            'comment_reported' => $validatedData->comment_reported,
            'post_reported' => 'NULL'
        ]);
    }

    public function vote(Request $request,$comment_id){
        $validatedData = $request->validate([
            'user_id' => 'required|numeric',
            'comment_id' => 'required|numeric',
            'like' => 'required|numeric'
        ]);

        DB::table('vote_comment')->insert([
            'user_id' => $validatedData['user_id'],
            'comment_id' => $validatedData['comment_id'],
            'like' => $validatedData['like']
        ]);
    }

    public function editVote(Request $request,$comment_id){
        $validatedData = $request->validate([
            'user_id' => 'required|numeric',
            'comment_id' => 'required|numeric',
            'like' => 'required|numeric'
        ]);

        DB::table('vote_comment')->where('user_id',$validatedData['user_id'])->
        where('comment_id',$validatedData['comment_id'])->update([
            'like' => $validatedData['like']
        ]);
    }


    public static function getPostComments($post_id){
        $comments = Comment::where("post_id",$post_id)->get();
        $result = array();
        foreach($comments as $comment){
            $votes = DB::table("vote_comment")->where("comment_id",$comment->id);
            $temp = $votes->get()->count();
            $likes = $votes->where("like",true)->get()->count();
            $dislikes = $temp - $likes;
            $threads = CommentController::getCommentThreads($comment->id);
            $temp_array = array();
            $temp_array["comment"] = $comment;
            $temp_array["likes"] = $likes;
            $temp_array["dislikes"] = $dislikes;
            $temp_array["date"] = date("F j, Y", strtotime($comment['comment_date']));
            $temp_array["author"] = AuthenticatedUser::find($comment->user_id)->name;
            $temp_array["threads"] = $threads;
            $temp_array["thread_count"] = count($threads);
            $result[] = $temp_array;
        }
        return $result;
    }

    public static function getCommentThreads($comment_id){
        $comments = Comment::where("comment_id",$comment_id)->get();
        $result = array();
        foreach($comments as $comment){
            $votes = DB::table("vote_comment")->where("comment_id",$comment->id);
            $temp = $votes->get()->count();
            $likes = $votes->where("like",true)->get()->count();
            $dislikes = $temp - $likes;
            $threads = Comment::where("comment_id",$comment->id);
            $temp_array = array();
            $temp_array["comment"] = $comment;
            $temp_array["likes"] = $likes;
            $temp_array["dislikes"] = $dislikes;
            $temp_array["date"] = date("F j, Y", strtotime($comment['comment_date']));
            $temp_array["author"] = AuthenticatedUser::find($comment->user_id)->name;
            $result[] = $temp_array;
        }
        return $result;
    }





    public static function commentsAsHtml($comments){
        $result = "";
        foreach($comments as $comment){
            $result = $result . "<div class=\"row justify-content-center px-4 mx-1\">
            <div class=\"col-10 post-page-comment pt-3 pb-2 px-3 mt-2\">
                <div class=\"row px-2 py-0\">
                    <div class=\"col-auto p-0 m-0\">
                        <h3 class=\"post-page-comment-body m-0\">". htmlspecialchars($comment['comment']->content). "</h3>
                    </div>
                    <div class=\"col-auto p-0 m-0 ms-auto\">
                        <i class=\"fas fa-chevron-down ms-auto\"></i>
                    </div>
                </div>
                <div class=\"row align-items-end px-2 py-1\">
                    <div class=\"col-lg-auto col-12 px-0 py-1 m-0 align-self-end\">
                        <h3 class=\"post-page-comment-author-date p-0 m-0\">by <a href=\"./userprofile.php\">" . htmlspecialchars($comment['author']) . "</a>, " .  htmlspecialchars($comment['date']) . "</h3>
                    </div>
                    <div class=\"col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto\">
                        <div class=\"row\">
                            <div class=\"d-flex\">
                                <h3 class=\"post-page-comment-interactions pe-3 my-0\">" .htmlspecialchars( $comment['likes']) . " <i title=\"Like comment\" class=\"far fa-thumbs-up\"></i></h3>
                                <h3 class=\"post-page-comment-interactions pe-3 my-0\">" . htmlspecialchars($comment['dislikes']) . " <i title=\"Dislike comment\" class=\"far fa-thumbs-down\"></i></h3>
                                <i title=\"Report comment\" class=\"fas fa-ban my-0 pe-3 post-page-report-comment\"></i>
                                <h3 class=\"post-page-comment-interactions my-0\">" . htmlspecialchars($comment['thread_count']) . " <i class=\"far fa-comments\"></i></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>\n";
        foreach($comment['threads'] as $thread){
            $result = $result . "<div class=\"row justify-content-center px-4 mx-1\">
            <div class=\"col-10 mx-0 px-0\">
                <div class=\"row justify-content-end comment-replies mx-0 px-0\">
                    <div class=\"col-11 post-page-comment-reply reply py-2 pt-2 pb-1 mt-1\">
                        <div class=\"row px-2 py-0\">
                            <div class=\"col-auto p-0 m-0\">
                                <h3 class=\"post-page-comment-reply-body m-0\">" . htmlspecialchars($thread['comment']->content) . "</h3>
                            </div>
                        </div>
                        <div class=\"row align-items-end px-2 py-0\">
                            <div class=\"col-lg-auto col-12 px-0 py-1 m-0 align-self-end\">
                                <h3 class=\"post-page-comment-reply-author-date p-0 m-0\">by <a href=\"./userprofile.php\">" . htmlspecialchars($thread['author']) . "</a>, " . htmlspecialchars($thread['date']) . "</h3>
                            </div>
                            <div class=\"col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto\">
                                <div class=\"row\">
                                    <div class=\"d-flex\">
                                        <h3 class=\"post-page-comment-interactions pe-3 my-0\">" . htmlspecialchars($thread['likes']) . " <i title=\"Like comment\" class=\"far fa-thumbs-up\"></i></h3>
                                        <h3 class=\"post-page-comment-interactions pe-3 my-0\">" . htmlspecialchars($thread['dislikes']) . " <i title=\"Dislike comment\" class=\"far fa-thumbs-down\"></i></h3>
                                        <i title=\"Report comment\" class=\"fas fa-ban my-0 post-page-report-comment\"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>";
        }
        $result = $result . "<div class=\"row justify-content-center px-4 mx-1\">
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
                                <button class=\"post-page-comment-button btn m-0 mt-1\">Comment</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>\n";
        
        
    }
        return $result;
    }












    

}
