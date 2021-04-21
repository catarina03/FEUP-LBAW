<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Report extends Model
{

    protected $table = 'report';

    protected $fillable = [
        'id', 'reported_date', 'accepted', ' closed_date',
        'motive', 'user_reporting', 'user_assigned', 
        'comment_reported','post_reported'];

    //associations with user(2) and post and comment
}
