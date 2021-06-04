@extends('layouts.app')

@section('content')
    <script  src="{{ URL::asset('js/toaster.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/settings.js') }}" defer></script>
    <div class="settings container-fluid md-g-0 sm-g-0" style="margin-top:4em;margin-bottom:5em;">
        <div class="row justify-content-start profile settings g-0 mt-4">
            <div class="col-3 col-lg-3 d-none d-lg-flex flex-column" style="padding-top:5%;">
                <nav class="nav flex-lg-column ">
                    <a href="{{url('user/'.$user->id)}}" class="my-profile-settings justify-content-center d-flex nav-link "><i title="profile"
                            class="bi bi-person-circle me-2"></i>Profile</a>
                    <a class="my-profile-settings justify-content-center d-flex nav-link active ms-3"><i
                            class="bi bi-gear me-2" title="settings"></i>
                        Settings</a>
                </nav>
            </div>

            <div class="col-lg-6 col-12 m-lg-0 mx-auto">

                <div class="row d-flex mt-2">
                    <div class="col-lg-12 col-8 pt-2">
                        <h2 id ="edit-account">Edit Account</h2>
                    </div>
                    <div class="d-lg-none col-4 pt-2">
                        <a href="{{ url('user/'.$user->id) }}" class="my-profile-settings go-profile"><i title="profile"
                                class="bi bi-person-circle fs-3 pe-2"></i>Profile</a>
                    </div>
                </div>
                <hr class="solid col-12">
                <form  method="POST" action=" {{ route('edit_account', $user->id)}}" >
                    @method('put')
                    {{ csrf_field() }}
                    <div class="mb-3 row">
                        <label for="name" class="justify-content-center d-flex col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="name" name="name" value="{{old('name',$user->name)}}">
                            @if ($errors->has('name'))
                                <span class="text-danger">
                                    {{ $errors->first('name') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="username"
                               class=" justify-content-center d-flex col-sm-2 col-form-label">Username</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="username" name="username" value="{{old('username', $user->username)}}">
                            @if ($errors->has('username'))
                                <span class="text-danger">
                                    {{ $errors->first('username') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="email" class="justify-content-center d-flex col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-9">
                            <input type="email" class="form-control" id="email" name="email" value="{{old('email', $user->email)}}">
                            @if ($errors->has('email'))
                                <span class="text-danger">
                                    {{ $errors->first('email') }}
                                </span>
                            @endif
                        </div>
                        <small id="emailHelp" class="form-text text-muted ps-5">We'll never share your email with anyone
                            else.</small>
                        <div>
                            @if(session('success-account'))
                                <span  class="form-text d-flex ps-4 text-success">{{session('success-account')}}</span>
                            @endif
                        </div>

                    </div>
                    <div class="col-12">
                        <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                            <a href="" style="text-decoration:none;"
                               class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button personal">Cancel</a>
                            <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                            <button type="submit"
                                    class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                                    id="change-personal-information"  style="width:fit-content;">Save Changes
                            </button>
                        </div>
                    </div>
                </form>

                <div class="row d-flex mt-3">
                    <h2 id="edit-social-networks"> Social Networks </h2>
                </div>
                <hr class="solid col-12">
                <form  method="POST" action=" {{ route('edit_social_networks', $user->id)}}">
                    {{ csrf_field() }}
                    @method('put')

                    <div class="mb-3 row">
                        <label for="twitter" class="justify-content-center d-flex col-sm-2 col-form-label"><i title="twitter"
                                class="fa fa-twitter"></i></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="twitter" name="twitter"
                                   placeholder="Add Twitter to your profile" value = "{{old('twitter', $user->twitter)}}">
                            @if ($errors->has('twitter'))
                                <span class="text-danger">
                                    {{ $errors->first('twitter') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="facebook" class="justify-content-center d-flex col-sm-2 col-form-label"><i title="facebook"
                                class="fa fa-facebook"></i></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="facebook" name="facebook"
                                   placeholder="Add Facebook to your profile" value="{{old('facebook', $user->facebook)}}">
                            @if ($errors->has('facebook'))
                                <span class="text-danger">
                                    {{ $errors->first('facebook') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="instagram" class="justify-content-center d-flex col-sm-2 col-form-label"><i title="instagram"
                                class="fa fa-instagram"></i></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="instagram" name="instagram"
                                   placeholder="Add Instagram to your profile" value="{{old('instagram',$user->instagram)}}">
                            @if ($errors->has('instagram'))
                                <span class="text-danger">
                                    {{ $errors->first('instagram') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="linkedin" class="justify-content-center d-flex col-sm-2 col-form-label"><i title="linkedin"
                                class="fa fa-linkedin"></i></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="linkedin" name="linkedin"
                                   placeholder="Add Linkedin to your profile" value="{{old('linkedin',$user->linkedin)}}">
                            @if ($errors->has('linkedin'))
                                <span class="text-danger">
                                    {{ $errors->first('linkedin') }}
                                </span>
                            @endif
                        </div>
                        <small class="form-text text-muted ps-5">Add valid urls.</small>
                        <div>
                            @if(session('success-social-networks'))
                                <span  class="form-text d-flex ps-4 text-success">{{session('success-social-networks')}}</span>
                            @endif
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                            <a href="" style="text-decoration:none;"
                               class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button social">Cancel</a>
                            <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                            <button type="submit"
                                    class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                                    id="change-social-networks" style="width:fit-content;">Save Changes
                            </button>
                        </div>
                    </div>
                </form>

                <div class="row d-flex mt-3">
                    <h2 id ="change-password"> Change Password </h2>
                </div>
                <hr class="solid col-12">

                <form  method="POST" action=" {{ route('change_password', $user->id)}}">
                    @csrf
                    @method('put')
                    <div class="mb-3 row">
                        <label for="currentPassword" class="justify-content-center d-flex col-sm-3 col-form-label">Current
                            Password</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="*******" required>
                            @if ($errors->has('currentPassword'))
                                <span class="text-danger">
                                    {{ $errors->first('currentPassword') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="newPassword" class="justify-content-center d-flex col-sm-3 col-form-label" >New
                            Password</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="*******" required>
                            @if ($errors->has('newPassword'))
                                <span class="text-danger">
                                    {{ $errors->first('newPassword') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="mb-3 row">
                        <label for="confirmPassword" class="justify-content-center d-flex col-sm-3 col-form-label">Confirm
                            Password</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="*******" required>
                            @if ($errors->has('confirmPassword'))
                                <span class="text-danger">
                                    {{ $errors->first('confirmPassword') }}
                                </span>
                            @endif
                        </div>
                        <div>
                            @if(session('success-password'))
                                <span  class="form-text d-flex ps-4 text-success">{{session('success-password')}}</span>
                            @endif
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                            <a href="" style="text-decoration:none;"
                               class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button password">Cancel</a>
                            <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                            <button type="submit"
                                    class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                                    id="change-password"  style="width:fit-content;">Change Password
                            </button>
                        </div>
                    </div>
                </form>

                <div class="row d-flex mt-3">
                    <h2 id="edit-preferences">Preferences </h2>
                </div>
                <hr class="solid col-12">
                <form  method="POST" action=" {{ route('edit_preferences', $user->id)}}">
                    @method('put')
                    {{ csrf_field() }}

                    <div class="mb-3 row justify-content-start ms-lg-5 ms-4">
                        <div class="form-check form-switch">
                            <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefaultPeopleFollow" name="peopleFollow"
                                   @if($user->show_people_i_follow)
                                   checked
                                   @endif

                            />
                            <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts from people I
                                follow by default</label>
                        </div>
                    </div>
                    <div class="mb-3 row justify-content-start ms-lg-5 ms-4">
                        <div class="form-check form-switch">
                            <input class="form-check-input switch " type="checkbox" id="flexSwitchCheckDefaultTagsFollow" name="tagsFollow"
                                   @if($user->show_tags_i_follow)
                                   checked
                                    @endif
                            />
                            <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts with tags I
                                follow
                                by default</label>
                        </div>
                    </div>

                    <div class="mb-3 row justify-content-start ms-lg-4 ms-0">
                        <label for="tags" class="col-sm-3 col-form-label">Tags I follow</label>
                        <section class="">
                            <select id="select2-tags" class="form-control bg-white rounded border" multiple="multiple" name="tags[]" >
                                @foreach($tags as $tag)
                                    <option value="{{$tag->id}}" selected>{{$tag->name}}</option>
                                @endforeach
                            </select>
                        </section>
                        <div>
                            @if(session('success-preferences'))
                                <span  class="form-text d-flex ps-4 text-success">{{session('success-preferences')}}</span>
                            @endif
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                            <a href="" style="text-decoration:none;"
                               class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button preferences">Cancel</a>
                            <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                            <button type="submit"
                                    class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                                    id="change-preferences" style="width:fit-content;">Save Changes
                            </button>
                        </div>
                    </div>
                </form>
                <div class="row d-flex mt-3">
                    <h2 id="delete-account">Delete Account</h2>
                </div>
                <hr class="solid col-12">
                <div class="row mb-3 ms-lg-5 ">
                   <div class="d-flex">
                       <span class="col-lg-12 col-12 delete-account-text align-middle  text-center mx-auto p-1">
                           Once you delete your account, there is no going back. Please be certain.</span>
                   </div>
                    <div class="d-flex justify-content-center my-2">
                        <span class="text-danger text-center error-delete d-none">
                            An error occurred trying to delete this account. Please try again later.
                        </span>
                    </div>
                    <div class="d-flex justify-content-center">
                        <a class="btn btn-danger d-flex btn-sm edit-account ps-5 pe-5" id="delete-account"
                           style="width:fit-content;height:fit-content;"  data-bs-toggle="modal"
                           data-bs-target="#confirm">Delete Account</a>
                    </div>

                </div>

            </div>

        </div>

    </div>
    @include('pages.confirm')
    @include('partials.list_toasters')
    @include('partials.error')
@endsection


