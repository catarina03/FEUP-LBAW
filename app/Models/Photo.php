<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Photo extends Model
{

    public $timestamps  = false;

    protected $table = 'photo';

    protected $fillable = ['id', 'photo','post_id'];

    //association with post
}
