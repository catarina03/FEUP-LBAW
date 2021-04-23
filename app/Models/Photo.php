<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Photo extends Model
{

    public $timestamps  = false;

    protected $table = 'photo';

    protected $fillable = ['photo','post_id'];

    /**
     * Get the post associated with the Photo
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function post(): HasOne
    {
        return $this->hasOne(Post::class, 'post_id');
    }
}
