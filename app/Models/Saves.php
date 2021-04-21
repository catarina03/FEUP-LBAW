<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Saves extends Model
{

    public $timestamps  = false;

    protected $table = 'saves';

    protected $fillable = ['user_id', 'post_id'];

    //associations with user and post
}
