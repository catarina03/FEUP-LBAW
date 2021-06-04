<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Str;

class ForgotPassword extends Controller
{
        /**
         * Display the specified resource.
         *
         * @return Application|Factory|View|Response
         */
        public function show()
        {
            return view('auth.forgotPassword',['needsFilter'=>0]);
        }


        public function showRecover(Request $request)
        {
            return view('auth.recoverPassword', ['needsFilter' => 0, 'token'=>$request->token]);

        }

        public function request(Request $request){
            $request->validate(['email' => 'required|email']);

            $status = Password::sendResetLink(
                $request->only('email')
            );

            return $status === Password::RESET_LINK_SENT
                ? back()->with('success', 'The recovery link was sent to your email, go check it out!')
                : back()->withErrors(['email' => __($status)]);

        }

        public function recover(Request $request){
            $request->validate([
                'token' => 'required',
                'email' => 'required|email',
                'password' => 'required|min:6|confirmed',
            ]);

            $status = Password::reset(
                $request->only('email', 'password', 'password_confirmation', 'token'),
                function ($user, $password) use ($request) {
                    $user->forceFill([
                        'password' => Hash::make($password)
                    ]);

                    $user->save();

                    event(new PasswordReset($user));
                }
            );

            return $status == Password::PASSWORD_RESET
                ? redirect()->route('login')
                : back()->withErrors(['email' => [__($status)]]);
        }
}
