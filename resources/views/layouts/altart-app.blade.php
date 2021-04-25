<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">

    <!-- TODO Was in app file, do we need it? -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>


    <!-- Styles -->
    <link href="{{ asset('css/style.css') }}" rel="stylesheet">
    <script type="text/javascript">
        // Fix for Firefox autofocus CSS bug
        // See: http://stackoverflow.com/questions/18943276/html-5-autofocus-messes-up-css-loading/18945951#18945951
    </script>
    <script type="text/javascript" src={{ asset('js/app.js') }} defer></script>


    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/45528450c3.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"
        integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js"
        integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous">
    </script>

    <script src="js/script.js" defer></script>
</head>

@section('navbar')
<?php
//include(app_path().'/views/auth/register.blade.php');
//include(app_path().'/views/auth/login.blade.php');
//include_once("./register.php");
//include_once("./login.php");

//needsFilter: 0 if not, 1 if filter posts, 2 if filter reports
//function draw_navbar($user, $needsFilter=0) {
?>

<nav class="navbar navbar-custom fixed-top navbar-expand-lg">
    <div class="container-fluid">
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbar">
            <span class="navbar-toggler-icon"><i class="fas fa-bars"></i></span>
        </button>
        <a href="homepage.php" class="navbar-brand ms-2"><img src="images/logo-sem-fundo.svg" height="30"
                                                              alt="AltArt Logo"></a>

        <?php if($needsFilter != 0) {?>
        <button class="navbar-toggler m-0 pt-3" data-bs-toggle="collapse" data-bs-target="#navbar-filter">
            <span class="navbar-toggler-icon m-0 p-0"><i class="bi bi-search"></i></span>
        </button>
        <?php } ?>



        <div class="navbar-collapse collapse w-100" id="navbar" navbar>
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a href="category_page.php" class="nav-link">Music</a></li>
                <li class="nav-item"><a href="category_page.php" class="nav-link">Cinema</a></li>
                <li class="nav-item"><a href="category_page.php" class="nav-link">TV Show</a></li>
                <li class="nav-item"><a href="category_page.php" class="nav-link">Theatre</a></li>
                <li class="nav-item"><a href="category_page.php" class="nav-link">Literature</a></li>
                <li>
                    <hr class="dropdown-divider" style="color:white;">
                </li>
                <li class="nav-item d-lg-none"><a href="./about.php" class="nav-link">About Us</a></li>
                <li class="nav-item d-lg-none"><a href="./faq.php" class="nav-link">FAQ</a></li>
                <li class="nav-item d-lg-none"><a href="./support.php" class="nav-link">Support</a></li>
            </ul>
            <ul class="navbar-nav d-flex">
                <?php
                if($user != "visitor") {
                ?>

                <li class="nav-item d-lg-block d-none ms-lg-3">
                    <a class="nav-link" data-togle="tooltip" data-placement="bottom" title="Create Post"
                       href="createpost.php" role="button" aria-expanded="false">
                        <i class="bi bi-plus-square-dotted navbar-icon"></i>
                    </a>
                </li>
                <?php
                if($user == "moderator" || ($user == "system_manager")){
                ?>
                <li class="nav-item d-lg-block d-none ms-lg-3"><a class="nav-link" href="./moderator_dashboard.php"
                                                                  role="button" data-togle="tooltip" data-placement="bottom" title="Manage Reports"
                                                                  aria-expanded="false">
                        <i class="bi bi-list-task navbar-icon"></i>
                    </a>
                </li>
                <?php }
                if($user == "system_manager") { ?>
                <li class="nav-item d-lg-block d-none ms-lg-3"><a class="nav-link" href="./manage_moderators.php"
                                                                  role="button" data-togle="tooltip" data-placement="bottom" title="Manage Moderators"
                                                                  aria-expanded="false">
                        <i class="bi bi-people-fill navbar-icon"></i>
                    </a>
                </li>

                <?php } ?>
                <li class="nav-item d-lg-block d-none dropdown ms-lg-3">
                    <a class="nav-link" href="" id="notificationsDropdown" role="button" data-bs-toggle="dropdown"
                       data-toggle="tooltip" data-placement="bottom" title="Notifications" aria-expanded="false">
                        <i class="bi bi-bell navbar-icon"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li><a class="dropdown-item" href="#"><i class="bi bi-hand-thumbs-up"></i> Someone liked your
                                post.</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-hand-thumbs-up"></i> Someone liked your
                                post.</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-chat-dots"></i> Someone liked your
                                post.</a></li>
                    </ul>
                </li>
                <li class="nav-item d-lg-block d-none dropdown mx-2 ms-lg-3">
                    <a class="nav-link" href="" id="profileDropdown" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <i class="bi bi-person-circle navbar-icon"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li><a class="dropdown-item" href="myprofile.php"><i class="bi bi-person me-2"></i> Profile</a>
                        </li>
                        <li><a class="dropdown-item" href="myprofile.php#"><i class="bi bi-bookmark me-2"></i> Saved
                                Posts</a></li>
                        <li><a class="dropdown-item" href="settings.php"><i class="bi bi-gear me-2"></i> Settings</a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-left me-2"></i> Sign out</a>
                        </li>
                    </ul>
                </li>
                <?php } elseif ($user=="visitor" ) { ?>
                <li class="nav-item me-3 d-lg-block d-none" data-bs-toggle="modal" data-bs-target="#register"><a
                        style="text-decoration:none;cursor:pointer;"><i class="fa fa-user pe-2"
                                                                        aria-hidden="true"></i>Sign Up</li>
                <li class="nav-item me-3 d-lg-block d-none" data-bs-toggle="modal" data-bs-target="#login"><a
                        style="text-decoration:none;cursor:pointer;"><i class="fa fa-sign-in pe-2"
                                                                        aria-hidden="true"></i>Login</a>
                </li>
                <?php
                }
                ?>
            </ul>
        </div>
        <?php if($needsFilter == 1) { ?>
        <div class="navbar-collapse collapse" id="navbar-filter" navbar>
            <ul class="navbar-nav custom-filterBox">
                <li class="nav-item d-lg-none container text-center w-100">
                    <form class="pt-2 " action="advanced_search.php" method="post">
                        <div class="input-group rounded">
                            <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                                   aria-describedby="search-addon" />
                            <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                                <i class="fas fa-search"></i>
                            </span>
                        </div>
                        <select class="form-select mt-4" aria-label="Select a type" style="cursor:pointer;">
                            <option selected>Select a type</option>
                            <option value="1">News</option>
                            <option value="2">Article</option>
                            <option value="3">Review</option>
                            <option value="4">Suggestion</option>
                        </select>
                        <input type="date" class="form-control mt-4" id="startDate" aria-label="Start Date"
                               style="cursor:pointer;">
                        <a> to </a>
                        <input type="date" class="form-control mt-2" id="endDate" aria-label="End Date"
                               style="cursor:pointer;">

                        <div class="form-check mt-4">
                            <input class="form-check-input" type="checkbox" value="" id="checkPeople"
                                   style="cursor:pointer;">
                            <label class="form-check-label" for="checkPeople">
                                Only people I follow
                            </label>
                        </div>
                        <div class="form-check mt-4">
                            <input class="form-check-input" type="checkbox" value="" id="checkTags"
                                   style="cursor:pointer;">
                            <label class="form-check-label" for="checkTags">
                                Only tags I follow
                            </label>
                        </div>

                        <input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">
                    </form>

                </li>
            </ul>
        </div>
        <?php } elseif ($needsFilter == 2) { ?>
        <div class="navbar-collapse collapse" id="navbar-filter" navbar>
            <ul class="navbar-nav custom-filterBox">
                <li class="nav-item d-lg-none container text-center w-100">
                    <form class="pt-2 " action="#" method="post">
                        <div class="input-group rounded">
                            <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                                   aria-describedby="search-addon" />
                            <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                                <i class="fas fa-search"></i>
                            </span>
                        </div>
                        <select class="form-select mt-4" aria-label="Select a type" style="cursor:pointer;">
                            <option selected>Select a type</option>
                            <option value="1">News</option>
                            <option value="2">Article</option>
                            <option value="3">Review</option>
                            <option value="4">Suggestion</option>
                        </select>
                        <select class="form-select mt-4" aria-label="Select a category" style="cursor:pointer;">
                            <option selected>Select a category</option>
                            <option value="1">Music</option>
                            <option value="2">Cinema</option>
                            <option value="3">TV Show</option>
                            <option value="4">Theatre</option>
                            <option value="5">Literature</option>
                        </select>
                        <select class="form-select mt-4" aria-label="Select date order" style="cursor:pointer;">
                            <option selected>Select date ordering</option>
                            <option value="1">Date: Newer</option>
                            <option value="2">Date: Older</option>
                            <option value="3">Date: Unordered</option>
                        </select>
                        <div class="form-check mt-4">
                            <input class="form-check-input" type="checkbox" value="" id="checkAssigned"
                                   style="cursor:pointer;">
                            <label class="form-check-label" for="checkAssigned">
                                Assign to me
                            </label>
                        </div>
                        <div class="form-check mt-4">
                            <input class="form-check-input" type="checkbox" value="" id="checkNotAssigned"
                                   style="cursor:pointer;">
                            <label class="form-check-label" for="checkNotAssigned">
                                Unassigned
                            </label>
                        </div>

                        <input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">
                    </form>

                </li>
            </ul>
        </div>
        <?php
        } ?>
    </div>
</nav>
@show

@yield('content')

@section('mobilebar')
    <footer class="bottomNavbar d-lg-none">
        <div id="buttonGroup" class="btn-group selectors" role="group" aria-label="Mobile bottom navbar">

            <a id="home" type="button" class="btn button-active" href="homepage.php">
                <div class="selector-holder pb-1">
                    <i class="bi bi-house fs-1"></i>
                </div>
            </a>
            <?php
            if($user == "moderator" || ($user == "system_manager")){
            ?>
            <a id="dashboard" type="button" class="btn button-inactive" href="moderator_dashboard.php">
                <div class="selector-holder">
                    <i class="bi bi-list-task fs-1"></i>
                </div>
            </a>
            <?php }
            if($user == "system_manager") { ?>
            <a id="roles_manager" type="button" class="btn button-inactive" href="./manage_moderators.php">
                <div class="selector-holder">
                    <i class="bi bi-people-fill fs-1"></i>
                </div>
            </a>
            <?php } ?>
            <?php if($user != "visitor") { ?>
            <a id="feed" type="button" class="btn button-inactive" href="createpost.php">
                <div class="selector-holder">
                    <i class="bi bi-plus-square-dotted fs-1"></i>
                </div>
            </a>
            <a id="notifications" type="button" class="btn button-inactive">

                <div class="selector-holder dropup">
                    <i data-bs-toggle="dropdown" aria-expanded="false" class="bi bi-bell fs-1"></i>

                    <ul class="dropdown-menu">
                        <li class="p-1">Someone liked your post.</li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="p-1">Someone liked your post.</li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="p-1">Someone liked your post.</li>
                    </ul>
                </div>
            </a>
            <a id="account" type="button" class="btn button-inactive">
                <div class="selector-holder dropup">
                    <i class="bi bi-person-circle fs-1" data-bs-toggle="dropdown" aria-expanded="false"></i>
                    <ul class="dropdown-menu">
                        <li class="p-1 ps-3 fs-4" onClick="location.href='myprofile.php'">Profile</li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="p-1 ps-3  fs-4" onClick="location.href='myprofile.php'">Saved Posts</li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="p-1 ps-3  fs-4" onClick="location.href='settings.php'">Settings</li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="p-1 ps-3  fs-4">Sign out</li>
                    </ul>
                </div>
            </a>
            <?php }
            else {?>
            <a id="login" type="button" class="btn button-inactive">
                <div class="selector-holder p-2" data-bs-toggle="modal" data-bs-target="#login">
                    <img src="./images/enter.svg" height="27px">
                </div>
            </a>
            <?php } ?>
        </div>
    </footer>
@show


@section('footer')
    {{-- @include(app_path().'/views/layouts/footer.blade.php'); --}}
    <footer class="text-center d-none d-lg-block mt-auto" style="background-color:#307371;">
        <!-- Grid container -->
        <div class="container">
            <!-- Section: Links -->
            <section class="mt-3 md-3">
                <!-- Grid row-->
                <div class="row text-center d-flex justify-content-center pt-4">
                    <!-- Grid column -->
                    <div class="col-md-2 mb-3">
                        <h6 class="text font-weight-bold">
                            <a class="footer-link" href="about.php">About us</a>
                        </h6>
                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-md-2 mb-3">
                        <h6 class="text font-weight-bold">
                            <a class="footer-link" href="faq.php">FAQ</a>
                        </h6>
                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-md-2 mb-3">
                        <h6 class="text font-weight-bold">
                            <a class="footer-link" href="support.php">Support</a>
                        </h6>
                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-md-2 mb-3">
                        <h6 class="text font-weight-bold">
                            <p class="footer-link">© AltArt</p>
                        </h6>
                    </div>
                </div>
            </section>
        </div>
    </footer>
@show




