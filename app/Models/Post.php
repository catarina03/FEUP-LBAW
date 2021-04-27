<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

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

    //notification on publish and vote?

}
