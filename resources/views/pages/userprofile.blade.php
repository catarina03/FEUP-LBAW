@extends('layouts.app')

@section('content')
<div class="row justify-content-center my-3 position-relative d-flex profile userprofile mx-2">
    <div class="col-lg-3 col-sm-4  d-flex justify-content-center ">
        <img class="rounded-circle profile-avatar"
             src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="200"
             height="200" alt="avatar">
    </div>
</div>
<div class="row justify-content-center d-flex mb-5 userprofile mx-2">
    <div class="card card-profile col-lg-7 col-xl-9 col-sm-9" style="border-radius:2%;">
        <div class="row justify-content-center mt-1">
            <div class="col-lg-2 col-sm-3 d-flex justify-content-center">
                <h5 class="card-title mt-5 profile-name">Ana Sousa</h5>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-2 d-flex justify-content-center">
                <p class="profile-username">@ana_sousa</p>
            </div>
        </div>


        <div class="card-body">
            <div class="row justify-content-center ">
                <div class="col-lg-6 col-sm-12">
                    <div class="row justify-content-around statistics-profile">
                        <div class="col-4 d-flex justify-content-center ">
                            <p>{{$nFollowers}} Followers</p>
                        </div>
                        <div class="col-4  d-flex justify-content-center">
                            <p>{{$nFollowing}} Following</p>
                        </div>
                        <div class="col-4  d-flex justify-content-center">
                            <p>{{$nLikes}} Likes</p>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row justify-content-center">
                <div class="card col-lg-6  d-flex justify-content-center"
                     style="background-color:#8ab5b1; border:none;">
                    <div class="row position-relative">
                        <div class=" row card-body bio ">
                            <div class="col-12  d-flex justify-content-center">
                                I am a senior editor and specialized in covering the evolution and impact of
                                brands.
                                Bidibodibi
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mt-3 ">
                <button type="button"
                        class="btn btn-secondary col-lg-3 col-sm-6 btn-sm profile-features follow">Follow</button>
                <button type="button"
                        class="btn btn-secondary col-lg-3 col-sm-6 btn-sm  profile-features block">Block</button>
            </div>
            <div class="row justify-content-center mt-2">
                <div class="col-lg-2 col-sm-4  d-flex justify-content-center">
                    <a href="https://www.instagram.com/"
                       class="btn btn-secondary btn-sm social-media d-flex justify-content-center">
                        <i class="bi bi-instagram"></i>
                    </a>
                    <a href="https://www.twitter.com/"
                       class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                        <i class="bi bi-twitter"></i>
                    </a>
                    <a href="https://www.facebook.com/"
                       class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                        <i class="bi bi-facebook"></i>
                    </a>
                    <a href="https://www.linkedin.com/"
                       class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                        <i class="bi bi-linkedin"></i>
                    </a>
                </div>
            </div>
            <div class="postsCards row justify-content-start mt-5">
                @each('partials.card', $posts, 'post')
            </div>
            @include('partials.pagination')
        </div>
    </div>

</div>
@endsection
