<?php

namespace App\Policies;

use App\Models\AuthenticatedUser;
use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class UserPolicy
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

    public static function edit($id){
        //only the owner of the account can access settings of this account
        return Auth::check() && Auth::user()->id == $id;
    }
}
