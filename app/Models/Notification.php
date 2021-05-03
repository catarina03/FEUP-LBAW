<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    public $timestamps  = false;

    protected $table = 'notification';

    protected $fillable = ['created_at',
    'notificated_user', 'read', 'type', 'post_id', 
    'follower_id', 'comment_id', 'voted_comment', 'voted_post', 'voted_user', 'report_id'];

    //associations with user(2), vote_comment, comment, vote_post, post, report
}
