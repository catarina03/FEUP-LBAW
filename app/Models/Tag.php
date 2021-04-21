<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{

    public $timestamps  = false;

    protected $table = 'tag';

    protected $fillable = ['id', 'name'];


    public function postTag(){
        return $this->belongsTo('App\Models\PostTag');
    }

    


}
