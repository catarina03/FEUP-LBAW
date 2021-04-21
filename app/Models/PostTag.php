<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PostTag extends Model
{


    public $timestamps  = false;

    protected $table = 'post_tag';

    protected $fillable = ['post_id', 'tag_id'];


    //associations with post and tag
    public function post(){
        return $this->hasMany('App\Models\Post');
    }

    public function tag(){
        return $this->hasMany('App\Models\Tag');
    }


}
