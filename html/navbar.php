<!DOCTYPE html>
<html lang="en">

<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style/style.css">
</head>

<body>
    <nav class="navbar navbar-custom">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">AltArt</a>
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
                    <li class="nav-item"><a class="nav-link" href="" role="button" aria-expanded="false">
                            <i class="bi bi-plus navbar-icon"></i>
                        </a></li>
                    <li class="nav-item"><a class="nav-link" href="" role="button" aria-expanded="false">
                            <i class="bi bi-list-task navbar-icon"></i>
                        </a></li>

                    <li class="nav-item dropdown">
                        <a class="nav-link" href="" id="notificationsDropdown" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            <i class="bi bi-bell navbar-icon"></i>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-hand-thumbs-up"></i> Someone liked
                                    your
                                    post.</a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-hand-thumbs-up"></i> Someone liked
                                    your
                                    post.</a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-chat-dots"></i> Someone liked your
                                    post.</a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown mx-2 ">
                        <a class="nav-link" href="" id="profileDropdown" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            <i class="bi bi-person-circle navbar-icon"></i>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-person"></i> Profile</a></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear"></i> Saved Posts</a></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear"></i> Settings</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-left me-5"></i> Sign out</a>
                            </li>
                        </ul>
                    </li>
                    <!--<li><a href="#"><span class="glyphicon glyphicon-user "></span> Sign Up</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>-->
                </ul>
            </div>
        </div>
    </nav>



    <div class="container">
        <h3>Collapsible Navbar</h3>
        <p>In this example, the navigation bar is hidden on small screens and replaced by a button in the top right
            corner (try to re-size this window).
        <p>Only when the button is clicked, the navigation bar will be displayed.</p>
    </div>
    

</body>

</html>