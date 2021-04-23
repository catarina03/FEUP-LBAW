<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{

    // Don't add create and update timestamps in database.
    //public $timestamps  = false; nao sei se queremos ou nao 

     /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'post';

    protected $fillable = ['title', 'thumbnail', 'content', 'is_spoiler', 'n_views', 'type', 'category', 'user_id'];


    public function user(){
        return $this->belongsTo('App\Models\User','user_id');
    }

    public function postTag(){
        return $this->belongsToMany('App\Models\PostTag');
    }

    //association with Tag, Vote, user, Notifciation, Report, Comment, Photo, Saves


    public function votedBy(){
        return $this->belongsToMany(AuthenticatedUser::class,"vote_post","user_id","post_id")->withPivot("like");
    }

    public function comments(){
        return $this->hasMany(Comment::class,"post_id");
    }
}
