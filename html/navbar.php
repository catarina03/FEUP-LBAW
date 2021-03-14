<?php
    include_once("./login.php");
    include_once("./register.php");
    function draw_navbar($user, $needsFilter=False) {
?>

<nav class="navbar navbar-custom fixed-top navbar-expand-lg">
    <div class="container-fluid">
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbar">
            <span class="navbar-toggler-icon"><i class="fas fa-bars"></i></span>
        </button>
        <a href="homepage.php" class="navbar-brand ms-2"><img src="images/logo-sem-fundo.svg" height="30"
                alt="AltArt Logo"></a>
        <?php if($needsFilter) {?>
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
                <li class="nav-item d-lg-block d-none ms-lg-3"><a class="nav-link" href="" role="button"
                        data-togle="tooltip" data-placement="bottom" title="Manage Reports" aria-expanded="false">
                        <i class="bi bi-list-task navbar-icon"></i>
                    </a>
                </li>
                <?php } 
                if($user == "system_manager") { ?>
                <li class="nav-item d-lg-block d-none ms-lg-3"><a class="nav-link" href="./role_manager.php"
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
                        style="text-decoration:none;cursor:pointer;"><i class="fa fa-user pe-2" aria-hidden="true"></i>Sign Up</li>
                <li class="nav-item me-3 d-lg-block d-none" data-bs-toggle="modal" data-bs-target="#login"><a
                        style="text-decoration:none;cursor:pointer;"><i class="fa fa-sign-in pe-2" aria-hidden="true"></i>Login</a>
                </li>
                <?php
              }
              ?>
            </ul>
        </div>
        <?php if($needsFilter) { ?>
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
        <?php } ?>
    </div>
</nav>

<?php
    }
    ?>