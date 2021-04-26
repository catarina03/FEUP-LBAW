@extends('layouts.altart-app')

@section('content')
<script type="text/javascript" src="{{ URL::asset('js/myprofile.js') }}" defer></script>
<div class="container-fluid my-profile justify-content-center mx-auto">
    <div class="row justify-content-start profile my-profile g-0">
        <div class="col-2 d-none d-xl-flex d-flex-column justify-content-center"
            style=" padding-left:1%; padding-top:10em; ">
            <nav class="nav flex-lg-column ">
                <a class="my-profile-settings justify-content-center d-flex nav-link active"><i
                        class="bi bi-person-circle me-2"></i>Profile</a>
                <a href="./settings.php" class="my-profile-settings justify-content-center d-flex nav-link ms-3"><i
                        class="bi bi-gear me-2"></i>
                    Settings</a>
            </nav>
        </div>
        <div class="col-xl-8 col-12 my-profile-div">
            <div class="row justify-content-center">
                <div class="col-12 d-block">
                    <div class="row justify-content-center d-flex my-3 position-relative ">
                        <div class="col-lg-3 col-md-3 col-sm-4 mb-3 d-flex justify-content-center ">
                            <img class="rounded-circle profile-avatar"
                                src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg"
                                width="200" height="200" alt="avatar">
                            <form action="#" method="post" data-toggle="tooltip" data-placement="bottom"
                                title="Update Profile Photo">
                                <div class="form-group">
                                    <label for="avatar" class="position-absolute d-inline corner-icons"
                                        style="transform:translate(-3em, 14em);"><svg xmlns="http://www.w3.org/2000/svg"
                                            width="40" height="40" fill="currentColor" class="bi bi-camera-fill"
                                            viewBox="0 0 16 16">
                                            <path d="M10.5 8.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z" />
                                            <path
                                                d="M2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2zm.5 2a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9 2.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0z" />
                                        </svg></label>
                                    <input type="file" class="form-control-file" accept=".jpeg,.jpg,.png,.gif"
                                        name="avatar" id="avatar" hidden>
                                </div>
                            </form>
                        </div>


                    </div>
                    <div class="row mt-1 d-flex justify-content-center">
                        <div class="card card-profile col-lg-12 col-xl-12 col-sm-9 mb-5 pb-5" style="border-radius:2%;">
                            <div class="row justify-content-center">
                                <div class="col-lg-2 col-10 d-flex justify-content-center text-center">
                                    <h5 class="card-title mt-5 profile-name">Ana Sousa</h5>
                                    <a href="./settings.php" class="position-absolute d-inline corner-icons d-xl-none"
                                        data-toggle="tooltip" data-placement="bottom" title="Settings"
                                        style="transform:translate(-4em, -1em);"><i class="bi bi-gear-fill pe-2"
                                            style="font-size:2.2em;"></i></a>
                                </div>
                            </div>
                            <div class="row justify-content-center">
                                <div class="col-lg-2 col-10 d-flex justify-content-center">
                                    <p class="profile-username">@ana_sousa</p>
                                </div>
                            </div>


                            <div class="card-body">
                                <div class="row justify-content-center ">
                                    <div class="col-lg-6 col-sm-12">
                                        <div class="row justify-content-around statistics-profile">
                                            <div class="col-4 d-flex justify-content-center text-center">
                                                <p>800 Followers</p>
                                            </div>
                                            <div class="col-4 d-flex justify-content-center text-center">
                                                <p>500 Following</p>
                                            </div>
                                            <div class="col-4 d-flex justify-content-center text-center">
                                                <p>900 Likes</p>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="row justify-content-center">
                                    <div class="card col-lg-6 col-sm-12 d-flex justify-content-center bio">
                                        <div class="row position-relative" data-toggle="tooltip" data-placement="bottom"
                                            title="Edit Bio">
                                            <a
                                                class="position-absolute top-0 end-0 translate-middle-y d-inline corner-icons pencil-icon">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
                                                    fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                                                    <path
                                                        d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z" />
                                                </svg>
                                            </a>
                                            <div class="row card-body bio ">
                                                <div class="col-12  text-center d-flex">
                                                    I am a senior editor and specialized in covering the evolution and
                                                    impact of
                                                    brands. Bidibodibi
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <form action="#" method="post" class=" col-lg-12 position-relative ">
                                        <div class="row position-relative d-none  justify-content-center bio-form">
                                            <div class="form-group row col-lg-6 justify-content-end">
                                                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"
                                                    style="resize:none;"></textarea>
                                                <button type="submit"
                                                    class="btn btn-sm col-2 me-2 mt-1 my-profile-features save-button save-form">Save</button>
                                            </div>
                                        </div>
                                    </form>

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
                                <div class="justify-content-center d-flex ">
                                    <div class="d-inline p-2 "><a href="#" class="my-profile-features active">My
                                            Posts</a></div>
                                    <div class="d-inline p-2">|</div>
                                    <div class="d-inline p-2"><a href="#" class="my-profile-features ">Saved Posts</a>
                                    </div>

                                </div>
                            </div>

                            <div class="postsCards row justify-content-start mt-3">
                            @include('partials.card')
                            @include('partials.card')
                            @include('partials.card')
                            @include('partials.card')
                            @include('partials.card')
                            @include('partials.card')
                            @include('partials.card')
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