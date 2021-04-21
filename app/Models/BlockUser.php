<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BlockUser extends Model
{

    public $timestamps  = false;

    protected $table = 'block_user';

    protected $fillable = ['blocking_user', 'blocked_user'];

    //associations with user(2)
}
