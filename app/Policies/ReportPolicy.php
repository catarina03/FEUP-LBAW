<?php

namespace App\Policies;

use App\Models\AuthenticatedUser;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Access\HandlesAuthorization;

class ReportPolicy
{
    use HandlesAuthorization;

    /**
     * Create a new policy instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public static function show(){
        //only moderators can view moderation page
        return Auth::check() && Auth::user()->isAdmin();
    }
}
