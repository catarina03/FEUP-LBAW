<?php 
    function draw_homepage(){
?>

<div class="homepage row g-0 mt-5 mb-5">
    <div class="homepage-left col-md-2 mt-5 d-flex flex-column" style="padding-left:6%;font-size: 21px;">
        <a href="#" class="active"><img src="images/bar-chart.svg" height="25"> Top </a>
        <a href="#" class="disable"><img src="images/flame.svg" height="25"> Hot </a>
        <a href="#" class="disable"><img src="images/calendar.svg" height="25"> New </a>
    </div>
    <div class="homepage-center col-md-7">
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
                                    <h4 class="card-title mb-3">Green Day Offers Up Punk-Inspired Aerobics in ‘Here
                                        Comes the
                                        Shock' Video</h4>
                                    <p class="card-text d-inline">Green Day is whipping fans into shape with its latest
                                        music video.

                                        On Saturday (Feb. 20), the rock band premiered their new song "Here Comes the
                                        Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The
                                        accompanying video features "Punk Rock Aerobics" co-founder Hilken Mancini
                                        taking viewers through an exercise punk-inspired routine filled with moves like
                                        the skank, Iggy's punch, air guitar, the circle jog and more.

                                        "We got the numbers/ Gonna rumble in the street/ We're screaming bloody murder/
                                        We're gonna take it to the grave," Green Day frontman Billie Joe Armstrong belts
                                        out on the fast-paced song.</p><span style="font-weight:bold;"> (read
                                        more)</span>
                                    <p class="card-text mt-3"><small class="text-muted">by João Santos , FEBRUARY 28,
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
                                    <h5 class="card-title">Card title</h5>
                                    <p class="card-text">This is a wider card with supporting text below as a natural
                                        lead-in to
                                        additional content. This content is a little bit longer.</p>
                                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
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
                                    <h5 class="card-title">Card title</h5>
                                    <p class="card-text">This is a wider card with supporting text below as a natural
                                        lead-in to
                                        additional content. This content is a little bit longer.</p>
                                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="postsCards row row-cols-4 g-0">
            <div class="card col-md-4 ms-2 mt-3" style="width: 22rem;">
                <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top" alt="...">
                <div class="card-body">
                    <h4 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock' Video
                    </h4>
                    <h6> by </h6><a href="https://www.google.com/">João Santos</a>
                    <h6>, FEBRUARY 28, 2021 </h6>
                    <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here Comes the
                        Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The accompanying
                        video
                        features "Punk Rock Aerobics" cofounder Hilken </p>
                </div>
            </div>
            <div class="card col-md-4 ms-3 mt-3" style="width: 22rem;">
                <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                    class="card-img-top" height="200" alt="...">
                <div class="card-body">
                    <h4 class="card-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New Video</h4>
                    <h6> by </h6><a href="https://www.google.com/">Ana Sousa</a>
                    <h6>, FEBRUARY 23, 2021 </h6>
                    <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in celebration
                        of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes scenes
                        of
                        the empty venue during the pandemic. "I would like to take this </p>

                </div>
            </div>
            <div class="card col-md-4 ms-3 mt-3" style="width: 22rem;">
                <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHw%3D&w=1000&q=80"
                    class="card-img-top" height="200" alt="...">
                <div class="card-body">
                    <h4 class="card-title">Hillary Clinton and Louise Penny to Write Political Thriller</h4>
                    <h6> by <a href="https://www.google.com/">Alexandra Alter</a>
                        <h6>, FEBRUARY 23, 2021 </h6>
                        <p class="card-text">In Louise Penny’s upcoming thriller, a novice secretary of state faces the
                            daunting task of rebuilding American leadership after years of diminishing influence abroad.
                            She is
                            immediately put to the test when a wave of terrorist attacks threatens to </p>

                </div>
            </div>
            <div class="col-md-4 card ms-2 mt-3" style="width: 22rem;">
                <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top" alt="...">
                <div class="card-body">
                    <h4 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock' Video
                    </h4>
                    <h6> by </h6><a href="https://www.google.com/">João Santos</a>
                    <h6>, FEBRUARY 28, 2021 </h6>
                    <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here Comes the
                        Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The accompanying
                        video
                        features "Punk Rock Aerobics" cofounder Hilken </p>
                </div>
            </div>
            <div class="card col-md-4 ms-3 mt-3" style="width: 22rem;">
                <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                    class="card-img-top" height="200" alt="...">
                <div class="card-body">
                    <h4 class="card-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New Video</h4>
                    <h6> by </h6><a href="https://www.google.com/">Ana Sousa</a>
                    <h6>, FEBRUARY 23, 2021 </h6>
                    <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in celebration
                        of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes scenes
                        of
                        the empty venue during the pandemic. "I would like to take this </p>

                </div>
            </div>
            <div class="card col-md-4 ms-3 mt-2" style="width: 22rem;">
                <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHw%3D&w=1000&q=80"
                    class="card-img-top" height="200" alt="...">
                <div class="card-body">
                    <h4 class="card-title">Hillary Clinton and Louise Penny to Write Political Thriller</h4>
                    <h6> by <a href="https://www.google.com/">Alexandra Alter</a>
                        <h6>, FEBRUARY 23, 2021 </h6>
                        <p class="card-text">In Louise Penny’s upcoming thriller, a novice secretary of state faces the
                            daunting task of rebuilding American leadership after years of diminishing influence abroad.
                            She is
                            immediately put to the test when a wave of terrorist attacks threatens to </p>

                </div>
            </div>
        </div>


    </div>
    <div class="filterBox col-md-3 d-flex justify-content-center">
        <form class="container text-center">
            <h4>Filter</h4>
            <div class="input-group rounded mt-4">
                <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search" />
            </div>
            <select class="form-select mt-4" aria-label="Default select example">
                <option selected>Select a category </option>
                <option value="1">News</option>
                <option value="2">Article</option>
                <option value="3">Review</option>
                <option value="4">Suggestion</option>
            </select>
            <input type="date" class="form-control mt-4" id="startDate" aria-label="Start Date">
            <a> to </a>
            <input type="date" class="form-control mt-2" id="endDate" aria-label="End Date">

            <input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">

        </form>
    </div>
</div>

<?php
}
?>