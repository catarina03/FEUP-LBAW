<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FollowUser extends Model
{


    public $timestamps  = false;

    protected $table = 'follow_user';

    protected $fillable = ['following_user', 'followed_user'];

    //associations with user(2)
}
