<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Str;

class ForgotPassword extends Controller
{
     public function index()
        {
            //
        }

        /**
         * Show the form for creating a new resource.
         *
         * @return Response
         */
        public function create()
        {

        }

        /**
         * Store a newly created resource in storage.
         *
         * @param Request $request
         * @return Response
         */
        public function store(Request $request)
        {

        }

        /**
         * Display the specified resource.
         *
         * @return Application|Factory|View|Response
         */
        public function show()
        {
            return view('auth.forgotPassword',['needsFilter'=>0]);
        }

        /**
         * Show the form for editing the specified resource.
         *
         * @param Report $report
         * @return Response
         */
        public function edit(Report $report)
        {
            //
        }

        /**
         * Update the specified resource in storage.
         *
         * @param Request $request
         * @param Report $report
         * @return Response
         */
        public function update(Request $request, Report $report)
        {
            //
        }

        /**
         * Remove the specified resource from storage.
         *
         * @param Report $report
         * @return Response
         */
        public function destroy(Report $report)
        {
            $report->delete();
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
