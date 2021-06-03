<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

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

    //notification on comment
}
