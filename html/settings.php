<?php
    
    function draw_settings() {
        
?>

<div class="container-fluid md-g-0 sm-g-0" style="margin-top:4em;margin-bottom:5em;">
    <div class="row justify-content-start profile settings g-0 mt-4">
        <div class="col-3 col-lg-3 d-none d-lg-flex flex-column" style="padding-top:5%;">
            <nav class="nav flex-lg-column ">
                <a href="./myprofile.php" class="my-profile-settings justify-content-center d-flex nav-link "><i
                        class="bi bi-person-circle me-2"></i>Profile</a>
                <a class="my-profile-settings justify-content-center d-flex nav-link active ms-3"><i
                        class="bi bi-gear me-2"></i>
                    Settings</a>
            </nav>
        </div>

        <div class="col-lg-6 col-12 m-lg-0 mx-auto">

            <div class="row d-flex mt-2">
                <div class="col-lg-12 col-8 pt-2">
                    <h2>Edit Account</h2>
                </div>
                <div class="d-lg-none col-4 pt-2">
                    <a href="./myprofile.php" class="my-profile-settings go-profile"><i
                            class="bi bi-person-circle fs-3 pe-2"></i>Profile</a>
                </div>


            </div>
            <hr class="solid col-12">
            <form action="#">
                <div class="mb-3 row">
                    <label for="name" class="justify-content-center d-flex col-sm-2 col-form-label">Name</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="name" placeholder="Ana Sousa">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="username"
                        class=" justify-content-center d-flex col-sm-2 col-form-label">Username</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="username" placeholder="@ana_sousa">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="email" class="justify-content-center d-flex col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-9">
                        <input type="email" class="form-control" id="email" placeholder="ana_sousa@gmail.com">
                    </div>
                    <small id="emailHelp" class="form-text text-muted ps-5">We'll never share your email with anyone
                        else.</small>
                </div>
                <div class="col-12">
                    <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                        <a href="myprofile.php" style="text-decoration:none;"
                            class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button">Cancel</a>
                        <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                        <button type="button"
                            class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                            id="change-personal-information" data-bs-toggle="modal" data-bs-target="#confirm"
                            style="width:fit-content;">Save Changes
                        </button>
                    </div>
                </div>
            </form>

            <div class="row d-flex mt-3">
                <h2> Social Networks </h2>
            </div>
            <hr class="solid col-12">
            <form action="#">
                <div class="mb-3 row">
                    <label for="twitter" class="justify-content-center d-flex col-sm-2 col-form-label"><i
                            class="fa fa-twitter"></i></label>
                    <div class="col-sm-9">
                        <input type="url" class="form-control" id="twitter" placeholder="Add Twitter to your profile">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="facebook" class="justify-content-center d-flex col-sm-2 col-form-label"><i
                            class="fa fa-facebook"></i></label>
                    <div class="col-sm-9">
                        <input type="url" class="form-control" id="facebook" placeholder="Add Facebook to your profile">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="instagram" class="justify-content-center d-flex col-sm-2 col-form-label"><i
                            class="fa fa-instagram"></i></label>
                    <div class="col-sm-9">
                        <input type="url" class="form-control" id="instagram"
                            placeholder="Add Instagram to your profile">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="linkedin" class="justify-content-center d-flex col-sm-2 col-form-label"><i
                            class="fa fa-linkedin"></i></label>
                    <div class="col-sm-9">
                        <input type="url" class="form-control" id="linkedin" placeholder="Add Linkedin to your profile">
                    </div>
                </div>
                <small class="form-text text-muted ps-5">Add valid urls.</small>
                <div class="col-12">
                    <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                        <a href="myprofile.php" style="text-decoration:none;"
                            class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button">Cancel</a>
                        <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                        <button type="button"
                            class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                            id="change-social-networks" data-bs-toggle="modal" data-bs-target="#confirm"
                            style="width:fit-content;">Save Changes
                        </button>
                    </div>
                </div>
            </form>

            <div class="row d-flex mt-3">
                <h2> Change Password </h2>
            </div>
            <hr class="solid col-12">

            <form action="#">
                <div class="mb-3 row">
                    <label for="currentPassword" class="justify-content-center d-flex col-sm-3 col-form-label">Current
                        Password</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" id="currentPassword" placeholder="*******">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="newPassword" class="justify-content-center d-flex col-sm-3 col-form-label">New
                        Password</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" id="newPassword" placeholder="*******">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="confirmPassword" class="justify-content-center d-flex col-sm-3 col-form-label">Confirm
                        Password</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" id="confirmPassword" placeholder="*******">
                    </div>
                </div>

                <div class="col-12">
                    <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                        <a href="myprofile.php" style="text-decoration:none;"
                            class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button">Cancel</a>
                        <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                        <button type="button"
                            class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                            id="change-password" data-bs-toggle="modal" data-bs-target="#confirm"
                            style="width:fit-content;">Change Password
                        </button>
                    </div>
                </div>
            </form>

            <div class="row d-flex mt-3">
                <h2>Preferences </h2>
            </div>
            <hr class="solid col-12">
            <form action="#">
                <div class="mb-3 row justify-content-around ms-5">
                    <div class="form-check form-switch">
                        <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts from people I
                            follow by default</label>
                    </div>
                </div>
                <div class="mb-3 row justify-content-around ms-5">
                    <div class="form-check form-switch">
                        <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts with tags I follow
                            by default</label>
                    </div>
                </div>
                <div class="mb-3 row justify-content-start ms-4">
                    <label for="tags" class="col-sm-3 col-form-label">Tags I follow</label>
                    <div class="col-sm-8 w-60">
                        <div class="bg-white rounded border form-control" id="tags" style="height:4em;">
                            <div class="d-flex justify-content-start tags">
                                <a class="btn btn-secondary btn-sm d-flex justify-content-center m-2">Music <i
                                        class="bi bi-x ms-1"></i></a>
                                <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">News <i
                                        class="bi bi-x ms-1"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 row">
                    <div class="col-lg-5 col-12 w-100justify-content-lg-start justify-content-center d-flex">
                        <button type="button"
                            class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                            id="delete-account" data-bs-toggle="modal" data-bs-target="#confirm"
                            style="width:fit-content;">Delete Account
                        </button>
                    </div>

                    <div class="col-lg-7 col-12 justify-content-lg-end justify-content-center d-flex">
                        <a href="myprofile.php" style="text-decoration:none;margin-right:2em;"
                            class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mb-1 mt-1 text-center cancel-button">Cancel</a>
                        <div class=" col-md-2 col-lg-1 col-8 mt-1 mb-1 ms-lg-0 ms-1 d-md-block d-none">or</div>
                        <button type="button"
                            class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                            id="save-preferences" data-bs-toggle="modal" data-bs-target="#confirm"
                            style="width:fit-content;">Save Changes
                        </button>
                    </div>
                </div>
            </form>
        </div>

    </div>

</div>


<script src="js/settings.js" defer></script>

<?php

    }
?>

<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Profile</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/45528450c3.js" crossorigin="anonymous"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"
        integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js"
        integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

    <link rel="stylesheet" href="style/style.css">
    <script src="js/script.js" defer></script>
</head>

<body class="d-flex flex-column min-vh-100">

    <?php
        include_once('./navbar.php');
        include_once('./confirm.php');
    
        draw_navbar("authenticated_user");

        draw_settings();

        include_once('./mobilebar.php');
        draw_mobilebar('authenticated_user');

        include_once('./footer.php');
        draw_footer();
?>


</body>


</html>