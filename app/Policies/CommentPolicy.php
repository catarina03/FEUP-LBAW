<?php

namespace App\Policies;

use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\Comment;


class CommentPolicy
{
    use HandlesAuthorization;

    /**
     * Create a new policy instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }
    public static function vote(Comment $comment){
        // only an authenticated_user that does not own the comment can vote a comment
        if($comment == null) return false;
        return Auth::check() && $comment->user_id !== Auth::user()->id;
    }

    public static function show(Comment $comment){
        // blocked users cant see posts
        if($comment == null) return false;
        $user_id = Auth::check()?Auth::user()->id:0;
        $blocked_users = DB::table("block_user")->where('blocked_user',$comment->user_id)->where("blocking_user",$user_id)->count();
        $blocking_users = DB::table("block_user")->where('blocked_user',$user_id)->where("blocking_user",$comment->user_id)->count();
        return $blocked_users == 0 && $blocking_users == 0;
        
    }
    


}
