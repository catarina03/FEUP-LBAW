<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VoteComment extends Model
{

    public $timestamps  = false;

    protected $table = 'vote_comment';

    protected $fillable = ['user_id', 'post_id', 'like'];

    //associations with user and comment
}
