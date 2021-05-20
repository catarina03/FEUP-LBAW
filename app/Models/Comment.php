<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Collection;
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

    public static function getPostComments($post_id,$date_order,$offset){
        
            $comments = Comment::where("post_id",$post_id)->orderBy("comment_date",$date_order)->get()->forPage($offset,5)->all();
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
        //$temp_array = array();
        //$temp_array["comment"] = $comment;
        $comment->likes = $likes;
        $comment->dislikes = $dislikes;
        $comment->comment_date = date("F j, Y", strtotime($comment['comment_date']));
        $comment->author = AuthenticatedUser::find($comment->user_id)->name;
        $comment->threads = $threads;
        $comment->thread_count = count($threads);
        return $comment;
    }

    public static function getThreadInfo($thread_id){
        $result = Comment::getCommentInfo($thread_id);
        unset($result->threads);
        unset($result->thread_count);
        return $result;
    }

    public static function commentsAsHtml($comments,$user_id){
        $comments = Comment::checkReported($comments);
        return view("partials.comments",["user_id"=> $user_id,"comments"=> $comments]);
    }

    public static function single_commentAsHtml($comment_id,$user_id){
        $comment = Comment::getCommentInfo($comment_id);
        $comment = Comment::checkReported(array($comment),$user_id);
        return view("partials.single_comment",["user_id"=>$user_id,"comment"=>$comment[0]]);
    }

    public static function checkReported($comments,$user_id){
        $new_comments = array();
        foreach($comments as $comment){
            $comment->reported=false;
            $report = Report::where("user_reporting",$user_id)->where("comment_reported",$comment->id)->get()->count();
            if($report>0)
                $comment->reported=true;
            if($comment->post_id != null && $comment->thread_count > 0){
                $comment->threads = Comment::checkReported($comment->threads,$user_id);
            }
            $new_comments[] = $comment;
        }
        //$new_comments = $comments;
        return $new_comments;
    }
}
