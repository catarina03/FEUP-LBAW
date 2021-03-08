<?php
    function draw_navbar($user) {
?>

<nav class="navbar navbar-custom fixed-top navbar-expand-lg">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><img src="images/logo-sem-fundo.svg" height="30" alt=""></a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Music</a></li>
                <li class=""><a href="#">Cinema</a></li>
                <li class=""><a href="#">Tv Show</a></li>
                <li class=""><a href="#">Theatre</a></li>
                <li class=""><a href="#">Literature</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <?php
                if($user == "authenticated_user" || ($user == "moderator")) {
              ?>
                <li class="nav-item  d-lg-block d-none ms-lg-3"><a class="nav-link" href="" role="button"
                        aria-expanded="false">
                        <i class="bi bi-plus navbar-icon"></i>
                    </a></li>
                <?php
                if($user == "moderator"){
                ?>
                <li class="nav-item  d-lg-block d-none ms-lg-3"><a class="nav-link" href="" role="button"
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
                        <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-bookmark me-2"></i> Saved Posts</a></li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Settings</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-left me-2"></i> Sign out</a>
                        </li>
                    </ul>
                </li>
                <?php }
                elseif ($user == "visitor") { ?>
                <li class="d-lg-none d-block">
                    <hr class="dropdown-divider" style="color: white;">
                </li>
                <li><a href="#"><span class="glyphicon glyphicon-user "></span> Sign Up</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
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