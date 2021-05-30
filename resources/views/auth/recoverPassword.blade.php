@extends('layouts.simple')
@section('content')
    <div class="container  align-items-center justify-content-center m-auto">
        <div class = "row  login-container justify-content-center ">
            <div class = "col-lg-5 col-md-8 col-sm-12 mt-lg-5 mt-md-4 mt-sm-2">
                <div class = "card " style="background-color: #fffefc;">
                    <div class="card-body py-4">
                        <div class="justify-content-center d-flex">
                            <img class=" d-flex" src="/images/logo-sem-fundo.svg" style="width:60%;">
                        </div>
                        <div class="d-block">
                            <h2 class="text-center">Recover Password</h2>
                            <p class="text-center">Please introduce your email to receive the recovery link!</p>
                        </div>

                        <form class="form-horizontal " method="POST" action="{{ route('recover_password')}}">
                            @csrf
                            <input type="hidden" value="{{$token}}" name="token">
                            <div class="form-row row d-flex justify-content-center">
                                <div class="form-group col-8">
                                    <label for="email" class="col-sm-12 col-form-label" style="font-weight: 600;">Email</label>
                                    <input id="email" type="email" class="form-control mt-2 px-2" name="email" value="{{ old('email') }}" required>
                                    @if($errors->has('email'))
                                        <span class="text-danger mt-0 mb-1" style="font-size:0.8rem;">
                                            {{$errors->first('email')}}
                                        </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-row row d-flex justify-content-center">
                                <div class="form-group col-8">
                                    <label for="password" class=" d-flex col-sm-12 col-form-label"  style="font-weight: 600;">New Password</label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="*******" required>
                                    @if ($errors->has('newPassword'))
                                        <span class="text-danger mt-0 mb-1" style="font-size:0.8rem;">
                                            {{ $errors->first('newPassword') }}
                                        </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-row row d-flex justify-content-center mb-3">
                                <div class="form-group col-8">
                                    <label for="password_confirmation" class=" col-sm-12 col-form-label"  style="font-weight: 600;">Confirm New Password </label>
                                    <input type="password" class="form-control" id="password_confirmation" name="password_confirmation" placeholder="*******" required>
                                    @if ($errors->has('confirmPassword'))
                                        <span class="text-danger mt-0 mb-1" style="font-size:0.8rem;">
                                            {{ $errors->first('confirmPassword') }}
                                        </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-12 mt-2 justify-content-center d-flex">
                                    <button type="submit" class="btn btn-block custom-button col-6">
                                        Recover Password
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
