<?php

namespace App\Models;
use App\Models\AuthenticatedUser;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Post extends Model
{

    protected $table = 'post';

    protected $fillable = ['title', 'thumbnail', 'content', 'is_spoiler', 'n_views', 'type', 'category', 'user_id'];

    public function author()
    {
        return $this->hasOne(AuthenticatedUser::class, 'user_id');
    }

    public function saved_by()
    {
        return $this->belongsToMany(AuthenticatedUser::class, 'saves', 'authenticatedUser_id', 'post_id');
    }

    public function tags()
    {
        return $this->belongsToMany(Tag::class, 'post_tag', 'post_id', 'tag_id');
    }

    public function photos()
    {
        return $this->hasMany(Photo::class, 'photo_id');
    }

    public function votedBy(){
        return $this->belongsToMany(AuthenticatedUser::class,"vote_post","user_id","post_id")->withPivot("like");
    }

    public function comments(){
        return $this->hasMany(Comment::class,"post_id");
    }

    public function reports()
    {
        return $this->hasMany(Report::class, 'post_reported');
    }

    public static function getTopPosts($page){
        if(Auth::check()){
            $user = Auth::user();
            $user_id = $user->id;
        }
        else{
            $user_id = 0;
        }
        return DB::select(
            DB::raw("select * from post where not exists
            (select * from block_user where ( block_user.blocked_user = post.user_id and block_user.blocking_user = " . $user_id . ")
            or (block_user.blocking_user = post.user_id and block_user.blocking_user = " . $user_id . "))
            order by n_views desc
            limit 15;"
               ,['user' => $user_id] ));
    }

    public static function getHotPosts($page){
        if(Auth::check()){
            $user = Auth::user();
            $user_id = $user->id;
        }
        else{
            $user_id = 0;
        }
        return DB::select(
            DB::raw("select * from post where not exists
            (select * from block_user where ( block_user.blocked_user = post.user_id and block_user.blocking_user = " . $user_id . ")
            or (block_user.blocking_user = post.user_id and block_user.blocking_user = " . $user_id . "))
            limit 15;"
               ,['user' => $user_id] ));
    }

    public static function getNewPosts($page){
        if(Auth::check()){
            $user = Auth::user();
            $user_id = $user->id;
        }
        else{
            $user_id = 0;
        }
        return DB::select(
            DB::raw("select * from post where not exists
            (select * from block_user where ( block_user.blocked_user = post.user_id and block_user.blocking_user = " . $user_id . ")
            or (block_user.blocking_user = post.user_id and block_user.blocking_user = " . $user_id . "))
            order by created_at desc
            limit 15;"
               ,['user' => $user_id] ));
    }

    public static function getSlideShowPosts(){
        if(Auth::check()){
            $user = Auth::user();
            $user_id = $user->id;
        }
        else{
            $user_id = 0;
        }
        return DB::select(
            DB::raw("select * from post where not exists
            (select * from block_user where ( block_user.blocked_user = post.user_id and block_user.blocking_user = " . $user_id . ")
            or (block_user.blocking_user = post.user_id and block_user.blocking_user = " . $user_id . "));"
               ,['user' => $user_id] ));
    }

    //notification on publish and vote?

}
