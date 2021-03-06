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
                        <button type="button" class="btn btn-secondary btn-sm  social-media">
                            <i class="bi bi-instagram fs-1"></i>
                        </button>
                        <button type="button" class="btn btn-secondary btn-sm  social-media">
                            <i class="bi bi-twitter fs-1"></i>
                        </button>
                        <button type="button" class="btn btn-secondary btn-sm  social-media">
                            <i class="bi bi-facebook fs-1"></i>
                        </button>
                        <button type="button" class="btn btn-secondary btn-sm  social-media">
                            <i class="bi bi-linkedin fs-1"></i>
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
    <div class="row justify-content-center">
        <div class="col-2 justify-content-center d-flex " style="margin-left:-18rem;">
            <div class="row justify-content-center d-flex " style="margin-top:280px; margin-left:20px;">
                <a href="#" class="my-profile-settings" style="margin-top:-10%;font-weight:bold;"> <svg
                        xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                        class="bi bi-person-circle" viewBox="0 0 16 16">
                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
                        <path fill-rule="evenodd"
                            d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
                    </svg> Profile</a>
                <a href="#" class="my-profile-settings" style="margin-top:-60%;"><svg xmlns="http://www.w3.org/2000/svg"
                        width="25" height="25" fill="currentColor" class="bi bi-gear" viewBox="0 0 16 16">
                        <path
                            d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z" />
                        <path
                            d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115l.094-.319z" />
                    </svg> Settings</a>
            </div>
            <div class="row justify-content-center d-flex" style="margin-top:110%;">

            </div>
        </div>
        <div class="col-8">
            <div class="row justify-content-center my-3 position-relative d-flex">
                <div class="col-lg-3 col-md-3 col-sm-4 d-flex justify-content-center ">
                    <img class="rounded-circle profile-avatar"
                        src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="200"
                        height="200" alt="avatar">
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
                                    <a class="position-absolute top-0 end-0 translate-middle-y d-inline corner-icons">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
                                            fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                                            <path
                                                d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z" />
                                        </svg>
                                    </a>
                                    <div class=" row card-body bio ">
                                        <div class="col-12  d-flex">
                                            I am a senior editor and specialized in covering the evolution and impact of
                                            brands. Bidibodibi
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>

                        <div class="row justify-content-center mt-2">
                            <div class="col-lg-2 col-sm-4 col-md-4 d-flex justify-content-center">
                                <button type="button" class="btn btn-secondary btn-sm  social-media">
                                    <i class="fa fa-instagram"></i>
                                </button>
                                <button type="button" class="btn btn-secondary btn-sm  social-media">
                                    <i class="fa fa-twitter"></i>
                                </button>
                                <button type="button" class="btn btn-secondary btn-sm  social-media">
                                    <i class="fa fa-facebook"></i>
                                </button>
                                <button type="button" class="btn btn-secondary btn-sm  social-media">
                                    <i class="fa fa-linkedin"></i>
                                </button>
                            </div>
                        </div>
                        <div class="row justify-content-center mt-3 ">
                            <button type="button" class="btn btn-secondary btn-sm profile-features">Follow</button>
                            <button type="button" class="btn btn-secondary btn-sm profile-features">Block</button>
                        </div>
                    </div>

                </div>
            </div>


        </div>



        <?php
    }
?>