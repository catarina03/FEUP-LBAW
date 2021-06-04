<?php

namespace App\Policies;

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

    public static function block($id, $blocking_id){
        //a user can not block themself
        if(!(Auth::check() && Auth::user()->id == $id)) return 1;
        if($id != $blocking_id) return 2;
        return  0;
    }

    public static function follow($id, $following_id){
        //a user can not follow themself
        if(!(Auth::check() && Auth::user()->id == $id)) return 1;
        if($id != $following_id) return 2;
        return  0;
    }
}
