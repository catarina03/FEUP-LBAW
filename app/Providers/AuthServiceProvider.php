<?php

namespace App\Providers;

use App\Models\AuthenticatedUser;
use App\Policies\UserPolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Auth\Notifications\ResetPassword;
use App\Policies\PostPolicy;
use App\Models\Post;
use App\Models\Comment;
use App\Policies\CommentPolicy;
use Illuminate\Support\Facades\URL;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
      Post::class => PostPolicy::class,
      AuthenticatedUser::class => UserPolicy::class,
      Comment::class => CommentPolicy::class
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        ResetPassword::createUrlUsing(function ($user, string $token) {
            return URL::to('/').'/recover_password?token='.$token;
        });
    }
}
