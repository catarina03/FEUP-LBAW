@extends('layouts.app')

@section('content')

<form class="row g-0" style="margin-bottom: 5em;margin-top:4em;" method="post" action="{{ route('register') }}">
    {{ csrf_field() }}
    <label for="email" class=" ms-1 col-form-label-sm text-white">Email</label>
    <div class=" row">
        <div class="col-sm-12">
            <input type="email" class="form-control" id="email" name="email" value="{{ old('email') }}" placeholder="email" required>
            @if ($errors->has('email'))
                <span class="error">
                {{ $errors->first('email') }}
                </span>
            @endif
        </div>
    </div>
    <label for="username" class=" ms-1 col-form-label-sm text-white">Username</label>
    <div class=" row">
        <div class="col-sm-12">
            <input type="text" class="form-control" id="username" name="username" value="{{ old('username') }}" placeholder="username" required>
            @if ($errors->has('username'))
                <span class="error">
                {{ $errors->first('username') }}
                </span>
            @endif
        </div>
    </div>
    <label for="name" class=" ms-1 col-form-label-sm text-white">Name</label>
    <div class=" row">
        <div class="col-sm-12">
            <input type="text" class="form-control" id="name" name="name" placeholder="name" value="{{ old('name') }}" required>
            @if ($errors->has('name'))
                <span class="error">
                {{ $errors->first('name') }}
                </span>
            @endif
        </div>
    </div>
    <label for="birthdate" class=" ms-1 col-form-label-sm text-white">Birthdate</label>
    <div class=" row">
        <div class="col-sm-12">
            <input type="date" class="form-control" id="birthdate" name="birthdate" value="{{ old('birthdate') }}" placeholder="dd/mm/aaaa"
                style="color:grey;" required>
                @if ($errors->has('birthdate'))
                <span class="error">
                {{ $errors->first('birthdate') }}
                </span>
            @endif
        </div>
    </div>
    <label for="password" class=" ms-1 col-form-label-sm text-white">Password</label>
    <div class=" row">
        <div class="col-sm-12">
            <input type="password" class="form-control" id="password" name="password" placeholder="*********" required>
            @if ($errors->has('password'))
                <span class="error">
                {{ $errors->first('password') }}
                </span>
            @endif
        </div>
    </div>
    <label for="password_confirmation" class=" ms-1 col-form-label-sm text-white">Repeat password</label>
    <div class=" row">
        <div class="col-sm-12">
            <input type="password" class="form-control" id="password_confirmation" name="password_confirmation" placeholder="*********" required>
        </div>
    </div>
    <div class="row mt-3  justify-content-center d-flex ">
        <button type="submit"
            class="btn btn-sm text-uppercase text-center col-8 btn-secondary authentication-buttons">Register</button>
    </div>

    <div class="or-container ms-1 mt-2 pe-5">
        <div class="line-separator"></div>
        <div class="or-label">or</div>
        <div class="line-separator"></div>
    </div>
    <div class="row mt-3 mb-2 justify-content-center ">
        <div class="col-10"> <a
                class="btn btn-sm btn-google btn-block btn-outline justify-content-center d-flex"
                href="#"><img src="https://img.icons8.com/color/16/000000/google-logo.png"
                    class="me-2 " style="width:10%; height:8%;"> Register with Google</a> </div>
    </div>


    <div class="row g-0 mb-4 mt-1 d-flex justify-content-center">
        <p class="text-center text-white ">Already have an account yet? <a href="#"
                style="text-decoration:none; color:white; font-weight:500;">
                Log in.</a></p>
    </div>
</form>

@endsection
