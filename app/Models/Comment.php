<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{

    //dont know if we want timestamps

    protected $table = 'comment';

    protected $fillable = ['id', 'content','user_id', 'comment_date', 'post_id', 'comment_id'];

    //associations with comment, post, user, voteComment, Report, Notification
    

}
