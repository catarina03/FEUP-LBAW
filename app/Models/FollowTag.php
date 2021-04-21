<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FollowTag extends Model
{

    public $timestamps  = false;

    protected $table = 'follow_tag';

    protected $fillable = ['user_id', 'tag_id'];

    //associations with user and Tag
}
