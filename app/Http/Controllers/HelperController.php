<?php

namespace App\Http\Controllers;
use App\Models\Post;
use App\Models\Tag;
use App\Models\AuthenticatedUser;
use App\Models\Comment;
use App\Policies\PostPolicy;
use App\Policies\CommentPolicy;
use App\Models\Report;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\DB;



class HelperController{
    public static function getPostComments($post_id,$date_order,$offset){
        $user_id = Auth::check()?Auth::user()->id:0;
        $comments = Comment::where("post_id",$post_id)->orderBy("comment_date",$date_order)->get()->forPage($offset,5)->all();
        $result = array();
        foreach($comments as $comment){
            $temp = HelperController::getCommentInfo($comment->id,$user_id);
            if($temp != null)
                $result[] = $temp;
        }
        return $result;
    }

    public static function getCommentThreads($comment_id, $user_id){
        $comments = Comment::where("comment_id",$comment_id)->orderBy("comment_date","desc")->get();
        $result = array();
        foreach($comments as $comment){
            $temp = HelperController::getCommentInfo($comment->id,$user_id);
            $result[] = $temp;
        }
        return $result;

    }

    public static function getCommentInfo($comment_id,$user_id){
        $comment = Comment::find($comment_id);
        if(!CommentPolicy::show($comment))
            return null;
        $votes = DB::table("vote_comment")->where("comment_id",$comment->id);
        $temp = $votes->get()->count();
        $likes = $votes->where("like",true)->get()->count();
        $dislikes = $temp - $likes;
        $threads = HelperController::getCommentThreads($comment->id,$user_id);
        $comment->likes = $likes;
        $comment->dislikes = $dislikes;
        $comment->comment_date = date("F j, Y", strtotime($comment['comment_date']));
        $comment->author = AuthenticatedUser::find($comment->user_id)->name;
        $comment->threads = $threads;
        $comment->thread_count = count($threads);
        $comment->isOwner = $comment->user_id == $user_id;
        $comment->reported=false;

        $like = DB::table("vote_comment")->where("comment_id",$comment->id)->where('user_id', $user_id)->value('like');
        if($like === true) $liked_c = 2;
        else if($like === false) $liked_c = 1;
        else $liked_c = 0;
        $comment->liked = $liked_c;

        $report = Report::where("user_reporting",$user_id)->where("comment_reported",$comment->id)->get()->count();
        if($report>0)
            $comment->reported=true;
        return $comment;
    }

    public static function commentsAsHtml($comments){
        return view("partials.comments",["comments"=> $comments]);
    }

    public static function single_commentAsHtml($comment_id,$user_id){
        $comment = HelperController::getCommentInfo($comment_id,$user_id);
        return view("partials.single_comment",["comment"=>$comment]);
    }
}
