<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{

    //dont know if we want timestamps

    protected $table = 'comment';

    protected $fillable = ['id', 'content','user_id', 'comment_date', 'post_id', 'comment_id'];

    //associations with comment, post, user, voteComment, Report, Notification
    
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
}
