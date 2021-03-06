<?php
    function draw_user_profile(){
?>
<div class="container profile">

    <div class="row justify-content-center my-3 position-relative d-flex">
        <div class="col-lg-3 col-sm-4 d-flex justify-content-center ">
            <img class="rounded-circle profile-avatar"
                src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="200"
                height="200" alt="avatar">
        </div>
    </div>
    <div class="row mt-1">
        <div class="card card-profile" style="border-radius:2%;">
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
                                <p>800 Followers</p>
                            </div>
                            <div class="col-4 d-flex justify-content-center">
                                <p>500 Following</p>
                            </div>
                            <div class="col-4 d-flex justify-content-center">
                                <p>900 Likes</p>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row justify-content-center">

                    <div class="card col-lg-6  d-flex justify-content-center">
                        <div class="row position-relative">
                            <div class=" row card-body bio ">
                                <div class="col-12  d-flex">
                                    I am a senior editor and specialized in covering the evolution and impact of brands.
                                    Bidibodibi
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
                <div class="row justify-content-center mt-3 ">
                    <button type="button" class="btn btn-secondary btn-sm profile-features">Follow</button>
                    <button type="button" class="btn btn-secondary btn-sm profile-features">Block</button>
                </div>
                <div class="row justify-content-center mt-2">
                    <div class="col-lg-2 col-sm-4  d-flex justify-content-center">
                        <button type="button"
                            class="btn btn-secondary btn-sm social-media d-flex justify-content-center">
                            <i class="bi bi-instagram"></i>
                        </button>
                        <button type="button"
                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                            <i class="bi bi-twitter"></i>
                        </button>
                        <button type="button"
                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                            <i class="bi bi-facebook"></i>
                        </button>
                        <button type="button"
                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                            <i class="bi bi-linkedin"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!--





    -->

    <?php
    }
?>

    <?php
    function draw_my_profile(){
?>

    <div class="row justify-content-start  g-0 mt-2 ms-5">
        <div class="col-lg-2 d-none d-lg-flex flex-column " style=" padding-left:3%;padding-top:15em; ">
            <a href="profile.php" class="my-profile-settings justify-content-center" style="font-weight:bold;"><i
                    class="bi bi-person-circle fs-4"></i> Profile</a>
            <a href="#" class="my-profile-settings justify-content-center"><i class="bi bi-gear fs-4"></i>
                Settings</a>
        </div>
        <div class="col-lg-8 col-sm-12">
            <div class="row justify-content-center mt-1 ms-1">
                <div class="col-12">
                    <div class="row justify-content-center my-3 position-relative d-flex">
                        <div class="col-lg-3 col-md-3 col-sm-4 d-flex justify-content-center ">
                            <img class="rounded-circle profile-avatar"
                                src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg"
                                width="200" height="200" alt="avatar">
                            <a class="position-absolute d-inline corner-icons" style="transform:translate(3em,13em);">
                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor"
                                    class="bi bi-camera-fill" viewBox="0 0 16 16">
                                    <path d="M10.5 8.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z" />
                                    <path
                                        d="M2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2zm.5 2a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9 2.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0z" />
                                </svg>
                            </a>
                        </div>


                    </div>
                    <div class="row mt-1">

                        <div class="card card-profile" style="border-radius:2%;">
                            <div class="row justify-content-center mt-1">
                                <div class="col-lg-2 col-md-2 col-sm-2 d-flex justify-content-center">
                                    <h5 class="card-title mt-5 profile-name">Ana Sousa</h5>
                                </div>
                            </div>
                            <div class="row justify-content-center">
                                <div class="col-2 col-md-2 d-flex justify-content-center">
                                    <p class="profile-username">@ana_sousa</p>
                                </div>
                            </div>


                            <div class="card-body">
                                <div class="row justify-content-center ">
                                    <div class="col-lg-6 col-sm-12">
                                        <div class="row justify-content-around statistics-profile">
                                            <div class="col-lg-4 col-md-4 col-sm-4 d-flex justify-content-center ">
                                                <p>800 Followers</p>
                                            </div>
                                            <div class="col-4 d-flex justify-content-center">
                                                <p>500 Following</p>
                                            </div>
                                            <div class="col-4 d-flex justify-content-center">
                                                <p>900 Likes</p>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="row justify-content-center">

                                    <div class="card col-lg-6 col-sm-12 d-flex justify-content-center">
                                        <div class="row position-relative">
                                            <a
                                                class="position-absolute top-0 end-0 translate-middle-y d-inline corner-icons">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
                                                    fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                                                    <path
                                                        d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z" />
                                                </svg>
                                            </a>
                                            <div class=" row card-body bio ">
                                                <div class="col-12  d-flex">
                                                    I am a senior editor and specialized in covering the evolution and
                                                    impact of
                                                    brands. Bidibodibi
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div>

                                <div class="row justify-content-center mt-2">
                                    <div class="col-lg-2 col-sm-4  d-flex justify-content-center">
                                        <button type="button"
                                            class="btn btn-secondary btn-sm social-media d-flex justify-content-center">
                                            <i class="bi bi-instagram"></i>
                                        </button>
                                        <button type="button"
                                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                                            <i class="bi bi-twitter"></i>
                                        </button>
                                        <button type="button"
                                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                                            <i class="bi bi-facebook"></i>
                                        </button>
                                        <button type="button"
                                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                                            <i class="bi bi-linkedin"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="justify-content-center d-flex ms-4">
                                    <div class="d-inline p-2 "><a href="#" class="my-profile-features" style="font-weight:bold;">My
                                            Posts</a></div>
                                    <div class="d-inline p-2">|</div>
                                    <div class="d-inline p-2"><a href="#" class="my-profile-features">Saved Posts</a>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>


                </div>

            </div>

            <?php
    }
?>