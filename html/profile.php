<?php
    function draw_user_profile(){
?>
<div class="container profile">

    <div class="row justify-content-center my-3 position-relative d-flex">
    <div class="col-lg-3 col-sm-4 d-flex justify-content-center ">
            <img class="rounded-circle profile-avatar" src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="200"
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
        </div>
    </div>

</div>

<!--
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-camera" viewBox="0 0 16 16">
  <path d="M15 12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1h1.172a3 3 0 0 0 2.12-.879l.83-.828A1 1 0 0 1 6.827 3h2.344a1 1 0 0 1 .707.293l.828.828A3 3 0 0 0 12.828 5H14a1 1 0 0 1 1 1v6zM2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2z"/>
  <path d="M8 11a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm0 1a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM3 6.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
</svg>

<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
</svg>

<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
</svg>

<i class="bi bi-gear"></i>
    -->

<?php
    }
?>

<?php
    function draw_my_profile(){
?>

<div class="container profile">

    <div class="row justify-content-center my-3 position-relative d-flex">
    <div class="col-lg-3 col-sm-4 d-flex justify-content-center ">
            <img class="rounded-circle profile-avatar" src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="200"
                height="200" alt="avatar">
        </div>
        <a class="position-absolute bottom-0 end-0 translate-middle-y d-inline corner-icons" style="transform: translateX(-100%);">
            <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="black" class="bi bi-camera" viewBox="0 0 16 16">
                <path d="M15 12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1h1.172a3 3 0 0 0 2.12-.879l.83-.828A1 1 0 0 1 6.827 3h2.344a1 1 0 0 1 .707.293l.828.828A3 3 0 0 0 12.828 5H14a1 1 0 0 1 1 1v6zM2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2z" />
                <path d="M8 11a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm0 1a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM3 6.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z" />
            </svg>
        </a>
        
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
                            <a class="position-absolute top-0 end-0 translate-middle-y d-inline corner-icons" >
                                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                    <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z" />
                                </svg>
                            </a>
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
        </div>
    </div>

</div>



<?php
    }
?>