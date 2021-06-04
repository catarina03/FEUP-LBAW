<nav class="navbar navbar-custom fixed-top navbar-expand-lg">
    <div class="container-fluid">
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbar">
            <span class="navbar-toggler-icon"><i class="fas fa-bars"></i></span>
        </button>
        <a href="{{url('/')}}" class="navbar-brand ms-2"><img src="/images/logo-sem-fundo.svg" height="30"
                                                              alt="AltArt Logo"></a>

        @if($needsFilter != 0)
            <button class="navbar-toggler m-0 pt-3" data-bs-toggle="collapse" data-bs-target="#navbar-filter">
                <span class="navbar-toggler-icon m-0 p-0"><i class="bi bi-search"></i></span>
            </button>
        @endif

        <div class="navbar-collapse collapse w-100" id="navbar" navbar>
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a href="{{url('category/Music')}}" class="nav-link">Music</a>
                </li>
                <li class="nav-item"><a href="{{url('category/Cinema')}}" class="nav-link">Cinema</a>
                </li>
                <li class="nav-item"><a href="{{url('category/TVShow')}}" class="nav-link">TV Show</a>
                </li>
                <li class="nav-item"><a href="{{url('category/Theatre')}}" class="nav-link">Theatre</a></li>
                <li class="nav-item"><a href="{{url('category/Literature')}}" class="nav-link">Literature</a>
                </li>
                <li>
                    <hr class="dropdown-divider" style="color:white;">
                </li>
                <li class="nav-item d-lg-none"><a href="{{url('/about')}}" class="nav-link">About Us</a></li>
                <li class="nav-item d-lg-none"><a href="{{url('/faq')}}" class="nav-link">FAQ</a></li>
                <li class="nav-item d-lg-none"><a href="{{url('/support')}}" class="nav-link">Support</a></li>
            </ul>
            <ul class="navbar-nav d-flex">
                @auth
                    <li class="nav-item d-lg-block d-none ms-lg-3">
                        <a class="nav-link" title="Create Post"
                           href="{{url('/addpost')}}" role="button" aria-expanded="false">
                            <i class="bi bi-plus-square-dotted navbar-icon"></i>
                        </a>
                    </li>

                    @if(Auth::user()->authenticated_user_type == "Moderator" || (Auth::user()->authenticated_user_type == "System Manager"))
                        <li class="nav-item d-lg-block d-none ms-lg-3"><a class="nav-link"
                                                                          href="{{ url('/moderator/reports') }}"
                                                                          role="button" title="Manage Reports"
                                                                          aria-expanded="false">
                                <i class="bi bi-list-task navbar-icon"></i>
                            </a>
                        </li>
                    @endif

                    @if(Auth::user()->authenticated_user_type == "System Manager")
                        <li class="nav-item d-lg-block d-none ms-lg-3"><a class="nav-link"
                                                                          href="{{url('/administration/roles')}}"
                                                                          role="button" title="Manage Roles"
                                                                          aria-expanded="false">
                                <i class="bi bi-people-fill navbar-icon"></i>
                            </a>
                        </li>
                    @endif

                    <li class="nav-item d-lg-block d-none dropdown ms-lg-3">
                        <a class="nav-link" href="" id="notificationsDropdown" role="button" data-bs-toggle="dropdown"
                           title="Notifications" aria-expanded="false">
                            <i class="bi bi-bell navbar-icon"></i>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-hand-thumbs-up"></i> Someone liked
                                    your
                                    post.</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-hand-thumbs-up"></i> Someone liked
                                    your
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
                            <li><a class="dropdown-item" href="{{ url('user/'.Auth::user()->id) }}"><i
                                        class="bi bi-person me-2"></i> Profile</a>
                            </li>
                            <li><a class="dropdown-item" href="{{ url('user/'.Auth::user()->id) }}"><i
                                        class="bi bi-bookmark me-2"></i> Saved
                                    Posts</a></li>
                            <li><a class="dropdown-item" href="{{ url('user/'.Auth::user()->id.'/settings') }}"><i
                                        class="bi bi-gear me-2"></i> Settings</a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="{{ route('logout') }}"><i
                                        class="bi bi-box-arrow-left me-2"></i> Sign out</a>
                            </li>
                        </ul>
                    </li>
                @endauth
                @guest
                    <li class="nav-item me-3 d-lg-block d-none" data-bs-toggle="modal" data-bs-target="#registerModal"><a
                                                                   style="text-decoration:none;cursor:pointer;"><i
                                class="fa fa-user pe-2"
                                aria-hidden="true"></i>Sign Up</a>
                    </li>
                    <li class="nav-item me-3 d-lg-block d-none show-login" data-bs-toggle="modal" data-bs-target="#loginModal"><a
                                                                   style="text-decoration:none;cursor:pointer;"><i
                                class="fa fa-sign-in pe-2"
                                aria-hidden="true"></i>Login</a>
                    </li>
                @endguest
            </ul>
        </div>

        @if($needsFilter == 1)
            <div class="navbar-collapse collapse d-sm-flex" id="navbar-filter" navbar>
                <ul class="navbar-nav custom-filterBox">
                    <li class="nav-item d-lg-none container text-center w-100">
                        <form class="pt-2 " action="advanced_search.php" method="post">
                            <div class="input-group rounded">
                                <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                                       aria-describedby="search-addon"/>
                                <span class="input-group-text border-0" id="search-addon"
                                      style="background-color:#fcf3ee;">
                                <i class="fas fa-search"></i>
                            </span>
                            </div>
                            <select class="form-select mt-4" aria-label="Select a type" style="cursor:pointer;">
                                <option value="" selected>Select a type</option>
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

                            <input type="submit" class="filterButton w-100 mt-4 p-1" value="Search">
                        </form>

                    </li>
                </ul>
            </div>
        @elseif ($needsFilter == 2)
            <div class="navbar-collapse collapse d-sm-flex d-none " id="navbar-filter" navbar>
                <ul class="navbar-nav custom-filterBox">
                    <li class="nav-item d-lg-none container text-center w-100">
                        <form class="pt-2 " action="#" method="post">
                            <div class="input-group rounded">
                                <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                                       aria-describedby="search-addon"/>
                                <span class="input-group-text border-0" id="search-addon"
                                      style="background-color:#fcf3ee;">
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
                                <option value="" selected>Select a category</option>
                                <option value="1">Music</option>
                                <option value="2">Cinema</option>
                                <option value="3">TV Show</option>
                                <option value="4">Theatre</option>
                                <option value="5">Literature</option>
                            </select>
                            <select class="form-select mt-4" aria-label="Select date order" style="cursor:pointer;">
                                <option value="" selected>Select date ordering</option>
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
        @endif
    </div>
</nav>
