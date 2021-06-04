<footer class="bottomNavbar d-lg-none">
    <div id="buttonGroup" class="btn-group selectors" role="group" aria-label="Mobile bottom navbar">

        <a id="home" type="button" class="btn button-active" href="/">
            <div class="selector-holder pb-1">
                <i class="bi bi-house fs-1"></i>
            </div>
        </a>

        @auth
            @if(Auth::user()->authenticated_user_type == "Moderator" || (Auth::user()->authenticated_user_type == "System Manager"))
                <a id="dashboard" type="button" class="btn button-inactive" href="{{url('/moderator/reports')}}">
                    <div class="selector-holder">
                        <i class="bi bi-list-task fs-1"></i>
                    </div>
                </a>
            @endif
            @if(Auth::user()->authenticated_user_type == "System Manager")
                <a id="roles_manager" type="button" class="btn button-inactive" href="{{url('/administration/roles')}}">
                    <div class="selector-holder">
                        <i class="bi bi-people-fill fs-1"></i>
                    </div>
                </a>
            @endif

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
                        <li class="p-1 ps-3 fs-4" onClick="location.href='{{ url('user/'.Auth::user()->id) }}'">
                            Profile
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="p-1 ps-3  fs-4" onClick="location.href='{{ url('user/'.Auth::user()->id) }}'">Saved
                            Posts
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="p-1 ps-3  fs-4"
                            onClick="location.href='{{ url('user/'.Auth::user()->id.'/settings') }}'">Settings
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li class="p-1 ps-3  fs-4" onclick="location.href='{{ route('logout') }}'">Sign out</li>
                    </ul>
                </div>
            </a>
        @endauth
        @guest
            <a id="login" type="button" class="btn button-inactive">
                <div class="selector-holder p-2" data-bs-toggle="modal" data-bs-target="#login">
                    <img src="{{URL::asset("./images/enter.svg")}}" height="27px" alt="login">
                </div>
            </a>
        @endguest
    </div>
</footer>
