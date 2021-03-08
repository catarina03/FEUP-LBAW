<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/45528450c3.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"
        integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js"
        integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

    <link rel="stylesheet" href="style/style.css">
    <script src="js/script.js" defer></script>
    <script src="js/userprofile.js" defer></script>
</head>

<body>

    <?php
        include_once('./navbar.php');

        draw_navbar("authenticated_user");
?>
    <div class="row justify-content-center my-3 position-relative d-flex profile userprofile mx-2">
        <div class="col-lg-3 col-sm-4  d-flex justify-content-center ">
            <img class="rounded-circle profile-avatar"
                src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="200"
                height="200" alt="avatar">
        </div>
    </div>
    <div class="row justify-content-center d-flex mt-5 mb-5 userprofile mx-2">
        <div class="card card-profile col-lg-7 col-xl-9 col-sm-9" style="border-radius:2%;">
            <div class="row justify-content-center mt-1">
                <div class="col-lg-2 col-sm-3 d-flex justify-content-center">
                    <h5 class="card-title mt-5 profile-name">Ana Sousa</h5>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-2 d-flex justify-content-center">
                    <p class="profile-username">@ana_sousa</p>
                </div>
            </div>


            <div class="card-body">
                <div class="row justify-content-center ">
                    <div class="col-lg-6 col-sm-12">
                        <div class="row justify-content-around statistics-profile">
                            <div class="col-4 d-flex justify-content-center ">
                                <p>800 Followers</p>
                            </div>
                            <div class="col-4  d-flex justify-content-center">
                                <p>500 Following</p>
                            </div>
                            <div class="col-4  d-flex justify-content-center">
                                <p>900 Likes</p>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row justify-content-center">
                    <div class="card col-lg-6  d-flex justify-content-center"
                        style="background-color:#8ab5b1; border:none;">
                        <div class="row position-relative">
                            <div class=" row card-body bio ">
                                <div class="col-12  d-flex justify-content-center">
                                    I am a senior editor and specialized in covering the evolution and impact of
                                    brands.
                                    Bidibodibi
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mt-3 ">
                    <button type="button"
                        class="btn btn-secondary col-lg-3 col-sm-6 btn-sm profile-features follow">Follow</button>
                    <button type="button"
                        class="btn btn-secondary col-lg-3 col-sm-6 btn-sm  profile-features block">Block</button>
                </div>
                <div class="row justify-content-center mt-2">
                    <div class="col-lg-2 col-sm-4  d-flex justify-content-center">
                        <a href="https://www.instagram.com/"
                            class="btn btn-secondary btn-sm social-media d-flex justify-content-center">
                            <i class="bi bi-instagram"></i>
                        </a>
                        <a href="https://www.twitter.com/"
                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                            <i class="bi bi-twitter"></i>
                        </a>
                        <a href="https://www.facebook.com/"
                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                            <i class="bi bi-facebook"></i>
                        </a>
                        <a href="https://www.linkedin.com/"
                            class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                            <i class="bi bi-linkedin"></i>
                        </a>
                    </div>
                </div>
                <div class="postsCards row justify-content-start mt-5">
                    <div class="col-12 col-lg-4 col-md-6 col-xl-4 mb-4">
                        <div class="card h-100">

                            <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                                alt="...">
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
                                <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes
                                    the Shock'
                                    Video </h5>
                                <small class="text-muted">by <a id="authorNamenothover">Ana Sousa</a>,
                                    FEBRUARY 28, 2021</small>
                                <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new
                                    song "Here
                                    Comes
                                    the
                                    Shock" as part of the National Hockey League's outdoor games in Lake Tahoe.
                                    The
                                    accompanying
                                    video
                                    features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
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
                                <h5 class="card-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall
                                    in New Video
                                </h5>
                                <small class="text-muted">by <a id="authorNamenothover">Ana Sousa</a>,
                                    FEBRUARY 23, 2021</small>
                                <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts
                                    Hall in
                                    celebration
                                    of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second
                                    film includes
                                    scenes
                                    of the empty venue during the pandemic. "I would like to take this
                                    <strong>(read
                                        more)</strong>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                        <div class="card h-100">

                            <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHw%3D&w=1000&q=80"
                                height="200" class="card-img-top" alt="...">
                            <div class="categoryTag">
                                <h6>Literature</h6>
                            </div>
                            <div class="savePost">
                                <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                            </div>

                            <div class="infoPosts">
                                <i class="far fa-eye"></i><span>3</span>
                                <i class="far fa-thumbs-up"></i><span>2</span>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Hillary Clinton and Louise Penny to Write Political
                                    Thriller</h5>
                                <small class="text-muted">by <a id="authorNamenothover">Ana Sousa</a>,
                                    FEBRUARY 23, 2021</small>
                                <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts
                                    Hall in
                                    celebration
                                    of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second
                                    film includes
                                    scenes
                                    of the empty venue during the pandemic. "I would like to take this
                                    <strong>(read
                                        more)</strong>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                        <div class="card h-100">

                            <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                                alt="...">
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
                                <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes
                                    the Shock'
                                    Video </h5>
                                <small class="text-muted">by <a id="authorNamenothover">Ana Sousa</a>,
                                    FEBRUARY 28, 2021</small>
                                <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new
                                    song "Here
                                    Comes
                                    the
                                    Shock" as part of the National Hockey League's outdoor games in Lake Tahoe.
                                    The
                                    accompanying
                                    video
                                    features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                        <div class="card h-100">

                            <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                                alt="...">
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
                                <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes
                                    the Shock'
                                    Video </h5>
                                <small class="text-muted">by <a id="authorNamenothover">Ana Sousa</a>,
                                    FEBRUARY 28, 2021</small>
                                <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new
                                    song "Here
                                    Comes
                                    the
                                    Shock" as part of the National Hockey League's outdoor games in Lake Tahoe.
                                    The
                                    accompanying
                                    video
                                    features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                        <div class="card h-100">

                            <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                                alt="...">
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
                                <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes
                                    the Shock'
                                    Video </h5>
                                <small class="text-muted">by <a id="authorNamenothover">Ana Sousa</a>,
                                    FEBRUARY 28, 2021</small>
                                <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new
                                    song "Here
                                    Comes
                                    the
                                    Shock" as part of the National Hockey League's outdoor games in Lake Tahoe.
                                    The
                                    accompanying
                                    video
                                    features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
    <?php
    
        include_once('./mobilebar.php');
        draw_mobilebar();
    ?>

</body>


</html>