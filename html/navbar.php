<?php 
    function draw_nav_bar(){
?>

<nav class="navbar-custom navbar navbar-expand-lg">
    <a href="#home" class="navbar-brand"><img src="/images/logo-sem-fundo.svg" style="width: 40%; margin-left:10%;"></a>
    <button aria-controls="basic-navbar-nav" type="button" aria-label="Toggle navigation"
        class="navbar-toggler collapsed navbar-light bg-light" data-toggle="collapse" style="color: white;">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="navbar-collapse collapse" id="basic-navbar-nav">
        <div class="justify-content-center w-100  navbar-nav" style="margin-left:20%;">
            <a href="#" data-rb-event-key="1" class="nav-link mr-5 active">Music</a>
            <a href="#" data-rb-event-key="1" class="nav-link mx-5 active">Cinema</a>
            <a href="#" data-rb-event-key="1" class="nav-link mr-5 active">TV Show</a>
            <a href="#" data-rb-event-key="1" class="nav-link mx-5 active">Theatre</a>
            <a href="#" data-rb-event-key="1" class="nav-link mr-5 active">Literature</a>
        </div>

        <ul class="nav navbar-nav w-100 justify-content-end">
            <li class="nav-item mx-2">
                <a class="nav-link" href="" id="#" role="button" aria-expanded="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor"
                        class="bi bi-plus" viewBox="0 0 16 16">
                        <path
                            d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z" />
                    </svg>
                </a>
            </li>
            <li class="nav-item dropdown mt-1">
                <a class="nav-link" href="" id="notificationsDropdown" role="button" data-bs-toggle="dropdown"
                    aria-expanded="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                        class="bi bi-bell" viewBox="0 0 16 16">
                        <path
                            d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z" />
                    </svg>
                </a>

                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                    <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Someone liked your post.</a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Someone liked your post.</a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Someone liked your post.</a>
                    </li>
                </ul>
            </li>

            <li class="nav-item dropdown mt-1 mx-2">
                <a class="nav-link" href="" id="profileDropdown" role="button" data-bs-toggle="dropdown"
                    aria-expanded="false">
                    <img class="rounded-circle me-2"
                        src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="35"
                        height="35" alt="avatar">
                </a>

                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                    <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Profile</a></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Saved Posts</a></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Settings</a></li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-left me-2"></i>Sign out</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<?php
}
?>