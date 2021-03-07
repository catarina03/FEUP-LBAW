<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="/images/logo-sem-fundo.svg" type="image/png">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
        integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"
        defer>
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style/custom_navbar.css">
</head>

<body>

    <?php
    include_once('./navbar.php');
    draw_nav_bar();
?>

    <script src="user-profile.js" defer></script>


        <div class="row justify-content-center my-3 position-relative d-flex user-profile">
            <div class="col-lg-3 col-sm-4  d-flex justify-content-center ">
                <img class="rounded-circle profile-avatar"
                    src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="200"
                    height="200" alt="avatar">
            </div>
        </div>
        <div class="row justify-content-center d-flex mt-1 user-profile">
            <div class="card card-profile col-lg-8 col-xl-8 col-sm-9" style="border-radius:2%;">
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
                                <div class="col-4 d-flex justify-content-center">
                                    <p>500 Following</p>
                                </div>
                                <div class="col-4 d-flex justify-content-center">
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
                                    <div class="col-12  d-flex text-center">
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
                            class="btn btn-secondary col-4 btn-sm profile-features follow">Follow</button>
                        <button type="button"
                            class="btn btn-secondary col-4 btn-sm profile-features block">Block</button>
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
                    <div class="postsCards row">
            <div class="col-12 col-md-6 col-xl-4 mt-4">
                <div class="card">
                    <img src="https://www.w3schools.com/w3css/img_lights.jpg" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                            Video </h5>
                            
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong></p>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">by <a id="authorName" href="https://www.google.com/">João Santos</a>, FEBRUARY 28, 2021</small>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-4 mt-4">
                <div class="card">
                    <img src="https://www.w3schools.com/w3css/img_lights.jpg" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                            Video </h5>
                            
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong></p>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">by <a id="authorName" href="https://www.google.com/">João Santos</a>, FEBRUARY 28, 2021</small>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-4 mt-4">
                <div class="card">
                    <img src="https://www.w3schools.com/w3css/img_lights.jpg" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                            Video </h5>
                            
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong></p>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">by <a id="authorName" href="https://www.google.com/">João Santos</a>, FEBRUARY 28, 2021</small>
                    </div>
                </div>
            </div>
            

        </div>
    </div>

                </div>
            </div>




        <?php
    //include_once('./footer.php');
    //draw_footer();
?>

</body>


</html>