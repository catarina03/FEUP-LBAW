<?php
    function draw_navbar($user) {
?>

<nav class="navbar navbar-custom fixed-top navbar-expand-lg">
    <div class="container-fluid">
        <a href="homepage.php" class="navbar-brand ms-2"><img src="images/logo-sem-fundo.svg" height="30" alt=""></a>
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbar">
            <span class="navbar-toggler-icon"><i class="fas fa-bars"></i></span>
        </button>

        <div class="navbar-collapse collapse" id="navbar" navbar>
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a href="category_page.php" class="nav-link">Music</a></li>
                <li class="nav-item"><a href="category_page.php" class="nav-link">Cinema</a></li>
                <li class="nav-item"><a href="category_page.php" class="nav-link">TV Show</a></li>
                <li class="nav-item"><a href="category_page.php" class="nav-link">Theatre</a></li>
                <li class="nav-item"><a href="category_page.php" class="nav-link">Literature</a></li>
            </ul>
            <ul class="navbar-nav d-flex">
                <?php
                if($user == "authenticated_user" || ($user == "moderator")) {
              ?>

                <li class="nav-item d-lg-block d-none ms-lg-3">
                    <a class="nav-link" data-togle="tooltip" data-placement="bottom" title="Create Post" href="createpost.php" role="button" aria-expanded="false">
                        <i class="bi bi-plus navbar-icon"></i>
                    </a>
                </li>
                <?php
                if($user == "moderator"){
                ?>
                <li class="nav-item d-lg-block d-none ms-lg-3"><a class="nav-link" href="" role="button"
                        aria-expanded="false">
                        <i class="bi bi-list-task navbar-icon"></i>
                    </a></li>
                <?php } ?>
                <li class="nav-item  d-lg-block d-none dropdown ms-lg-3">
                    <a class="nav-link" href="" id="notificationsDropdown" role="button" data-bs-toggle="dropdown"
                        aria-expanded="false">
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
                <?php }
                elseif ($user == "visitor") { ?>
                <li class="nav-item d-lg-none d-block">
                    <hr class="dropdown-divider" style="color: white;">
                </li>
                <li class="nav-item me-3"><a href="#" style="text-decoration:none;"><i class="fa fa-user pe-2"
                            aria-hidden="true"></i>Sign Up</a></li>
                <li class="nav-item me-3"><a href="#" style="text-decoration:none;"><i class="fa fa-sign-in pe-2"
                            aria-hidden="true"></i>Login</a></li>
                <?php
              }
              ?>
            </ul>
        </div>
    </div>
</nav>

<?php
    }
    ?>