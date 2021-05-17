@extends('layouts.app')

@section('content')
<script type="text/javascript" src="{{ URL::asset('js/myprofile.js') }}" defer></script>
<script type="text/javascript" src="{{ URL::asset('js/update_profile_photo.js') }}" defer></script>
<div class="container-fluid my-profile justify-content-center mx-auto">
    <div class="row justify-content-start profile my-profile g-0">
        <div class="col-2 d-none d-xl-flex d-flex-column justify-content-center"
            style=" padding-left:1%; padding-top:10em; ">
            <nav class="nav flex-lg-column ">
                <a class="my-profile-settings justify-content-center d-flex nav-link active"><i
                        class="bi bi-person-circle me-2"></i>Profile</a>
                <a href="{{ url("user/".Auth::user()->id."/settings") }}" class="my-profile-settings justify-content-center d-flex nav-link ms-3"><i
                        class="bi bi-gear me-2"></i>
                    Settings</a>
            </nav>
        </div>
        <div class="col-xl-8 col-12 my-profile-div">
            <div class="row justify-content-center">
                <div class="col-12 d-block">

                    <div class="row justify-content-center d-flex my-3 position-relative ">
                        <div class="col-lg-3 col-md-3 col-sm-4 mb-3 d-flex justify-content-center profile-photo-section">
                            @include('partials.profilephoto')
                        </div>
                    </div>

                    <div class="row mt-1 d-flex justify-content-center">
                        <div class="card card-profile col-lg-12 col-xl-12 col-sm-9 mb-5 pb-5" style="border-radius:2%;">
                            <div class="row justify-content-center">
                                <div class="col-lg-2 col-10 d-flex justify-content-center text-center">
                                    <h5 class="card-title mt-5 profile-name">{{$user->name}}</h5>
                                    <a href="./settings.php" class="position-absolute d-inline corner-icons d-xl-none"
                                        data-toggle="tooltip" data-placement="bottom" title="Settings"
                                        style="transform:translate(-4em, -1em);"><i class="bi bi-gear-fill pe-2"
                                            style="font-size:2.2em;"></i></a>
                                </div>
                            </div>
                            <div class="row justify-content-center">
                                <div class="col-lg-2 col-10 d-flex justify-content-center">
                                    <p class="profile-username">@</p><p class="profile-username">{{$user->username}}</p>
                                </div>
                            </div>


                            <div class="card-body">
                                <div class="row justify-content-center ">
                                    <div class="col-lg-6 col-sm-12">
                                        <div class="row justify-content-around statistics-profile">
                                            <div class="col-4 d-flex justify-content-center text-center">
                                                <p>{{$nFollowers}} Followers</p>
                                            </div>
                                            <div class="col-4 d-flex justify-content-center text-center">
                                                <p>{{$nFollowing}} Following</p>
                                            </div>
                                            <div class="col-4 d-flex justify-content-center text-center">
                                                <p>{{$nLikes}} Likes</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                @include('partials.profilebio')

                                <div class="row justify-content-center mt-2">
                                    <div class="col-lg-2 col-sm-4  d-flex justify-content-center">
                                        @if($user->instagram != null)
                                        <a href="{{ url($user->instagram) }}"
                                            class="btn btn-secondary btn-sm social-media d-flex justify-content-center">
                                            <i class="bi bi-instagram"></i>
                                        </a>
                                        @endif
                                        @if($user->twitter != null)
                                        <a href="{{ url($user->twitter) }}"
                                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                                            <i class="bi bi-twitter"></i>
                                        </a>
                                        @endif
                                        @if($user->facebook != null)
                                        <a href="{{ url($user->facebook) }}"
                                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                                            <i class="bi bi-facebook"></i>
                                        </a>
                                        @endif
                                        @if($user->linkedin != null)
                                        <a href="{{ url($user->linkedin) }}"
                                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                                            <i class="bi bi-linkedin"></i>
                                        </a>
                                        @endif
                                    </div>
                                </div>
                                <div class="justify-content-center d-flex ">
                                    <div class="d-inline p-2 "><a href="#" class="my-profile-features active">My
                                            Posts</a></div>
                                    <div class="d-inline p-2">|</div>
                                    <div class="d-inline p-2"><a href="#" class="my-profile-features ">Saved Posts</a>
                                    </div>

                                </div>
                            </div>

                            <div class="postsCards row justify-content-start mt-3">
                                @each('partials.card', $posts, 'post')
                            </div>
                            <div class="d-flex justify-content-center">
                                <div class="pagination">
                                    <a href="#">&laquo;</a>
                                    <a href="#" class="active">1</a>
                                    <a href="#">2</a>
                                    <a href="#">3</a>
                                    <a href="#">&raquo;</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


            </div>


        </div>

    </div>
</div>
@endsection
