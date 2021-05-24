<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{

    public $timestamps  = false;

    protected $table = 'tag';

    protected $fillable = ['name'];

    /**
     * Get all of the posts for the Tag
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function posts(): HasMany
    {
        return $this->belongsToMany(Post::class, 'post_tag', 'post_id', 'tag_id');
    }


    /**
     * Get all of the tag_followers for the Tag
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function tag_followers(): HasMany
    {
        return $this->belongsToMany(AuthenticatedUser::class,'follow_tag','user_id','tag_id');
    }



}
