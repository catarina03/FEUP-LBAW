<?php

namespace App\Policies;

use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;
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


}
