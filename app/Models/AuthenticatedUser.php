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
        'username', 'name', 'email', 'password', 'birthdate', 'bio', 'instagram', 'twitter', 'facebook', 'linkedin', 'show_people_i_follow', 'show_tags_i_follow','authenticated_user_type', 'profile_photo'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];


    /**                              Associations                           */



    /**
     * The cards this user owns.
     */
     public function authored_posts() {
      return $this->hasMany(Post::class, 'user_id');
    }

    /**
     * The reports made by the user
     */
    public function reports(){
        return $this->hasMany(Report::class,"user_reporting");
    }

    /**
     * Comments made by the user
    */
    public function comments(){
        return $this->hasMany(Comment::class, "authenticatedUser_id");
    }

    /**
    * Reports assigned to the user
    */
    public function assigned_reports(){
        return $this->hasMany(Report::class,"user_assigned");
    }

    public function following_tags(){
        return $this->belongsToMany(Tag::class,"follow_tag","tag_id","authenticatedUser_id");
    }

    public function followers(){
        return $this->belongsToMany(AuthenticatedUser::class,"follow_user","followed_user","following_user");
    }

    public function following(){
        return $this->belongsToMany(AuthenticatedUser::class,"follow_user","following_user","followed_user");
    }

    public function blocked(){
        return $this->belongsToMany(AuthenticatedUser::class,"block_user","blocked_user","blocking_user");
    }

    public function blockedBy(){
        return $this->belongsToMany(AuthenticatedUser::class,"block_user","blocking_user","blocked_user");
    }

    public function voted_comments(){
        return $this->belongsToMany(Comment::class,"vote_comment","comment_id","authenticatedUser_id")->withPivot("like");
    }

    public function voted_posts(){
        return $this->belongsToMany(Post::class,"vote_post","post_id","authenticatedUser_id")->withPivot("like");
    }

    public function saved_posts()
    {
        return $this->belongsToMany(Post::class, 'saves', 'authenticatedUser_id', 'post_id');
    }

    public function isAdmin(): bool
    {
        return (($this->authenticated_user_type == "System Manager") || ($this->authenticated_user_type == "Moderator"));
    }

    public function isSM(): bool
    {
        return $this->authenticated_user_type == "System Manager";
    }
}
