<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Support extends Model
{

    public $timestamps  = false;

    protected $table = 'support';

    protected $fillable = ['problem','browser', 'frequency', 'impact', ' email'];

}
