<?php 
    function draw_homepage(){
?>

<div class="homepage row g-0 mt-lg-5 mb-5">
    <div class="homepage-view col-md-2 ps-5 pt-3">
        <nav class="nav flex-lg-column">
            <a class="nav-link active" href="#"><img src="images/bar-chart.svg" height="25">Top</a>
            <a class="nav-link" href="#"><img src="images/flame.svg" height="25">Hot</a>
            <a class="nav-link" href="#"><img src="images/calendar.svg" height="25">New</a>
        </nav>
    </div>
    <div class="homepage-center col-12 col-lg-7">
        <div id="topNews" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#topNews" data-bs-slide-to="0" class="active" aria-current="true"
                    aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#topNews" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#topNews" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-md-7">
                                <img src="https://static.toiimg.com/photo/72975551.cms" class="w-100" alt="...">
                            </div>
                            <div class="col-md-5">
                                <div class="card-body">
                                    <h5 class="card-title mb-3">Green Day Offers Up Punk-Inspired Aerobics in ‘Here
                                        Comes the Shock' Video</h5>
                                    <p class="card-text d-inline">Green Day is whipping fans into shape with its latest
                                        music video. On Saturday (Feb. 20), the rock band premiered their new song "Here
                                        Comes the
                                        Shock" as part of the National Hockey </p>
                                    <strong> (read more)</strong>
                                    <p class="card-text mt-3"><small class="text-muted">by <a
                                                href="user-profile.php" id="authorName">João Santos</a>,
                                            FEBRUARY 28,
                                            2021</small></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-md-7">
                                <img src="https://wallpaperaccess.com/full/2587267.jpg" class="w-100" alt="...">
                            </div>
                            <div class="col-md-5">
                                <div class="card-body">
                                    <h5 class="card-title mb-3">Green Day Offers Up Punk-Inspired Aerobics in ‘Here
                                        Comes the Shock' Video</h5>
                                    <p class="card-text d-inline">Green Day is whipping fans into shape with its latest
                                        music video. On Saturday (Feb. 20), the rock band premiered their new song "Here
                                        Comes the
                                        Shock" as part of the National Hockey </p>
                                    <strong> (read more)</strong>
                                    <p class="card-text mt-3"><small class="text-muted">by <a
                                                href="user-profile.php" id="authorName">João Santos</a>,
                                            FEBRUARY 28,
                                            2021</small></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-md-7">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_Kwz7sjcydklqSsq9kf9hBI4eZwsVO7-dZg&usqp=CAU"
                                    class="w-100" alt="...">
                            </div>
                            <div class="col-md-5">
                                <div class="card-body">
                                    <h5 class="card-title mb-3">Green Day Offers Up Punk-Inspired Aerobics in ‘Here
                                        Comes the Shock' Video</h5>
                                    <p class="card-text d-inline">Green Day is whipping fans into shape with its latest
                                        music video. On Saturday (Feb. 20), the rock band premiered their new song "Here
                                        Comes the
                                        Shock" as part of the National Hockey </p>
                                    <strong> (read more)</strong>
                                    <p class="card-text mt-3"><small class="text-muted">by <a
                                                href="user-profile.php" id="authorName">João Santos</a>,
                                            FEBRUARY 28,
                                            2021</small></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="postsCards row">
            <div class="col-12 col-md-6 col-xl-4 mb-4">
                <div class="card h-100">
                    <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                        alt="...">
                    <div class="categoryTag">
                        <h6>Music</h6>
                    </div>
                    <div class="infoPosts">
                        <i class="far fa-eye"></i><span>3</span>
                        <i class="far fa-thumbs-up"></i><span>2</span>
                    </div>
                    <div class="savePost">
                        <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                            Video </h5>
                        <small class="text-muted">by <a id="authorName" href="user-profile.php">João Santos</a>,
                            FEBRUARY 28, 2021</small>
                        <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here
                            Comes
                            the
                            Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The
                            accompanying
                            video
                            features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong></p>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-4 mb-4">
                <div class="card h-100">
                    <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                        height="200" class="card-img-top" alt="...">
                    <div class="categoryTag">
                        <h6>Music</h6>
                    </div>
                    <div class="savePost">
                        <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                    </div>
                    <div class="infoPosts">
                        <i class="far fa-eye"></i><span>3</span>
                        <i class="far fa-thumbs-up"></i><span>2</span>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New Video
                        </h5>
                        <small class="text-muted">by <a id="authorName" href="user-profile.php">Ana Sousa</a>,
                            FEBRUARY 23, 2021</small>
                        <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in
                            celebration
                            of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes
                            scenes
                            of the empty venue during the pandemic. "I would like to take this <strong>(read
                                more)</strong></p>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-4 mb-4">
                <div class="card h-100">
                    <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHw%3D&w=1000&q=80"
                        height="200" class="card-img-top" alt="...">
                    <div class="categoryTag">
                        <h6>Literature</h6>
                    </div>
                    <div class="infoPosts">
                        <i class="far fa-eye"></i><span>3</span>
                        <i class="far fa-thumbs-up"></i><span>2</span>
                    </div>
                    <div class="savePost">
                        <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Hillary Clinton and Louise Penny to Write Political Thriller</h5>
                        <small class="text-muted">by <a id="authorName" href="user-profile.php">Alexandra
                                Alter</a>,
                            FEBRUARY 23, 2021</small>
                        <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in
                            celebration
                            of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes
                            scenes
                            of the empty venue during the pandemic. "I would like to take this <strong>(read
                                more)</strong></p>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-4 mb-4">
                <div class="card h-100">
                    <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                        alt="...">
                    <div class="categoryTag">
                        <h6>Music</h6>
                    </div>
                    <div class="infoPosts">
                        <i class="far fa-eye"></i><span>3</span>
                        <i class="far fa-thumbs-up"></i><span>2</span>
                    </div>
                    <div class="savePost">
                        <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                            Video </h5>
                        <small class="text-muted">by <a id="authorName" href="user-profile.php">João Santos</a>,
                            FEBRUARY 28, 2021</small>
                        <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here
                            Comes
                            the
                            Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The
                            accompanying
                            video
                            features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="homepage-filter col-md-3 text-center">
        <div class="container">
            <h4> Search </h4>
            <form class="pt-2" action="#" method="post">
                <div class="input-group rounded">
                    <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                        aria-describedby="search-addon" />
                    <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                        <i class="fas fa-search"></i>
                    </span>
                </div>
                <select class="form-select mt-4" aria-label="Select a type">
                    <option selected>Select a type</option>
                    <option value="1">News</option>
                    <option value="2">Article</option>
                    <option value="3">Review</option>
                    <option value="4">Suggestion</option>
                </select>
                <input type="date" class="form-control mt-4" id="startDate" aria-label="Start Date">
                <a> to </a>
                <input type="date" class="form-control mt-2" id="endDate" aria-label="End Date">

                <div class="form-check mt-4">
                    <input class="form-check-input" type="checkbox" value="" id="checkPeople">
                    <label class="form-check-label" for="checkPeople">
                        Only people I follow
                    </label>
                </div>
                <div class="form-check mt-4">
                    <input class="form-check-input" type="checkbox" value="" id="checkTags">
                    <label class="form-check-label" for="checkTags">
                        Only tags I follow
                    </label>
                </div>

                <!--<input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">-->
                <a href="advanced_search.php" class="filterButton w-100 mt-4 p-1">Filter</a>
            </form>
        </div>
    </div>
</div>

<footer class="bottomNavbar d-lg-none">
    <div id="buttonGroup" class="btn-group selectors" role="group" aria-label="Basic example">
        <button id="home" type="button" class="btn button-active">
            <div class="selector-holder">
                <i class="bi bi-house fs-2"></i>
                <p>Home</p>
            </div>
        </button>
        <button id="feed" type="button" class="btn button-inactive">
            <div class="selector-holder">
                <i class="bi bi-plus fs-2"></i>
                <p>Create</p>
            </div>
        </button>
        <button id="create" type="button" class="btn button-inactive">
            <div class="selector-holder">
                <i class="bi bi-bell fs-2"></i>
                <p>Notifications</p>
            </div>
        </button>
        <button id="account" type="button" class="btn button-inactive">
            <div class="selector-holder">
                <i class="bi bi-person-circle fs-2"></i>
                <p>@ana_sousa</p>
            </div>
        </button>
    </div>
</footer>

<?php
}
?>