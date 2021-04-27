<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Report extends Model
{

    protected $table = 'report';

    protected $fillable = [
        'reported_date', 'accepted', ' closed_date',
        'motive', 'user_reporting', 'user_assigned', 
        'comment_reported','post_reported'];

     /**
     * Get the user_reporting associated with the Report
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function user_reporting()
    {
        return $this->belongsTo(AuthenticatedUser::class, 'user_reporting');
    }

    /**
     * Get the user_assigned associated with the Report
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function user_assigned()
    {
        return $this->hasOne(AuthenticatedUser::class, 'user_assigned');
    }

    /**
     * Get the post associated with the Report
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function post_reported()
    {
        return $this->hasOne(Post::class, 'post_reported');
    }

    //associations with user(2) and post and comment
    /**
     * Get the comment associated with the Report
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function comment_reported(): HasOne
    {
        return $this->hasOne(Comment::class, 'comment_reported');
    }
    

    //notification on report
}
