<?php

namespace App\Models;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class AuthenticatedUser extends Authenticatable
{
    use Notifiable;

    // Don't add create and update timestamps in database.
    public $timestamps  = false;

    protected $table = 'authenticated_user';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id','username', 'name', 'email', 'password', 'birthdate', 'bio', 'instagram', 'twitter', 'facebook', 'linkedin', 'show_people_i_follow', 'show_tags_i_follow','authenticated_user_type', 'profile_photo'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The cards this user owns.
     */
     public function posts() {
      return $this->hasMany('App\Models\Post');
    }

    //association with Post, Followtag, FollowUser,BlockUser, Report, Vote Comment, VotePost, Comment       
}
