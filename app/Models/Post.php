<?php

namespace App\Models;
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

    public static function getPostsOrdered($order, $page){
        $offset = ($page-1) * 15;
        if(Auth::check()){
            $user = Auth::user();
            $user_id = $user->id;
            if($user->show_people_i_follow) $people = true;
            else $people = false;
            if($user->show_tags_i_follow) $tags = true;
            else $tags = false;
        }
        else{
            $user_id = 0;
            $people = false;
            $tags = false;
        }

        if($people) $extra_query_1 = " AND user_id in (select followed_user from follow_user where following_user = '{$user_id}') ";
        else $extra_query_1 = "";

        if($tags){
            $extra_query_2 = " AND id in (select post_id from follow_tag join post_tag on(post_tag.tag_id = follow_tag.tag_id) where user_id = '{$user_id}')";
        }
        else $extra_query_2 = "";


        $aux = "select * from post where not exists
            (select * from block_user where ( block_user.blocked_user = post.user_id and block_user.blocking_user = :user)
            or (block_user.blocking_user = post.user_id and block_user.blocking_user = :user))";

        if($order == "hot")
            $query = $aux.$extra_query_1.$extra_query_2." order by n_views desc";
        else if($order == "top"){
            $query = "SELECT *, n_likes
            FROM post, (SELECT post_id, COUNT(user_id) AS n_likes
            FROM vote_post
            WHERE vote_post.like
            GROUP BY post_id
            union
            SELECT id AS post_id, 0 AS n_likes
            FROM post
            WHERE not exists (SELECT DISTINCT post_id from vote_post WHERE vote_post.like = true AND vote_post.post_id = post.id)) AS likes_post
            WHERE likes_post.post_id = post.id and not exists
            (select * from block_user where ( block_user.blocked_user = post.user_id and block_user.blocking_user = :user)
            or (block_user.blocking_user = post.user_id and block_user.blocking_user = :user)) ".$extra_query_1.$extra_query_2." order by n_likes desc";
        }
        else if($order == "new"){
            $query = $aux.$extra_query_1.$extra_query_2."order by created_at desc";
        }
        else{
            $query = $aux." order by n_views desc";
        }
        if(Auth::check()){
            $count = count(DB::select(DB::raw($query),['user' => $user_id]));
        }
        else $count = Post::count();
        $query = $query.' OFFSET :offset ROWS FETCH NEXT 15 ROWS ONLY;';

        return array('results'=> DB::select(DB::raw($query),['user' => $user_id, 'offset' => $offset]), 'n_posts'=> $count);
    }

    public static function getSlideShowPosts(){
        if(Auth::check()){
            $user = Auth::user();
            $user_id = $user->id;
        }
        else $user_id = 0;

        return DB::select(
            DB::raw("select * from post where not exists
            (select * from block_user where ( block_user.blocked_user = post.user_id and block_user.blocking_user = :user)
            or (block_user.blocking_user = post.user_id and block_user.blocking_user = :user))
            order by n_views limit 3;")
               ,['user' => $user_id] );
    }


}
