<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VotePost extends Model
{

    public $timestamps  = false;

    protected $table = 'vote_post';

    protected $fillable = ['user_id', 'post_id', 'like'];

    //associations with user and post
}
