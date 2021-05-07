<?php

namespace App\Policies;

use App\Models\AuthenticatedUser;
use App\Models\Post;

use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PostPolicy
{
    use HandlesAuthorization;

    public function show(AuthenticatedUser $user)
    {
      // Any user can view a post
      return Auth::check();
    }

    public function list(AuthenticatedUser $user)
    {
      // Any user can list its own posts
      return Auth::check();
    }

    public function create(AuthenticatedUser $user)
    {
      // Any user can create a new post
      return Auth::check();
    }

    public function delete(User $user, Post $post)
    {
      // Only a post owner can delete it
      return $user->id == $post->user_id;
    }

    public function save(AuthenticatedUser $user, Post $post)
    {
      // A post owner cannot save its own post
      return $user->id != $post->user_id;
    }

    public static function show_post(AuthenticatedUser $user, Post $post){
      $blocked_users = DB::table("block_user")->where('blocked_user',$post->user_id)->where("blocking_user",$user->id)->count();
      $blocking_users = DB::table("block_user")->where('blocked_user',$user->id)->where("blocking_user",$post->user_id)->count();
      return $blocked_users == 0 && $blocking_users == 0;
    }
}
