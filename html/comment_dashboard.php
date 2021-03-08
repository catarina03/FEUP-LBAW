<?php 
    function draw_cdashboard(){
?>
<h1 class="text-center">Dashboard</h1>
<div class="row g-0 justify-content-center">
    <div style="padding-left:0;" class="col-lg-1 col-md-1 ms-1 d-lg-flex d-md-none d-sm-none d-xs-none settings-vertical">
        <div style="padding-left:0;">
            <i class="bi bi-pencil-square"></i><a style="text-decoration:none;">
                <p style="color:black;">Posts</p>
            </a> <br>
            <i class="bi bi-chat-dots"></i><a href="comment_dashboard.php" style="text-decoration:none;color:black;">
                <p style="font-weight:bold;">Comments</p>
            </a>
        </div>
    </div>
    <div class="col-12 justify-content-center d-sm-flex d-lg-none d-md-flex settings-horizontal">
        <div class="row justify-content-center">
            <div class="col-4 mx-auto">
                <i class="bi bi-pencil-square"></i><a style="text-decoration:none;">
                    <p style="color:black;">Posts</p>
                </a>
            </div>
            <div class="col-4 mx-auto">
                <i class="bi bi-chat-dots"></i><a href="comment_dashboard.php"
                    style="text-decoration:none;color:black;font-weight:bold;">
                    <p>Comments</p>
                </a>
            </div>
        </div>
    </div>
    <div class="col-sm-10 col-md-8 col-lg-3 mt-5 ml-5">
        <h3 class="text-center" style="font-weight:bold">Unassigned</h3>
        <div class="card" style="background-color:#8ab5b1;border:none;">
            <div class="card-body">
                <div class="row justify-content-center mb-4">
                    <div class="col-sm-12 col-md-auto col-lg-3">
                        <select class="form-select pdash-form w-100 h-100" aria-label="Default select example">
                            <option selected>Category</option>
                            <option value="1">All</option>
                            <option value="2">News</option>
                            <option value="3">Article</option>
                            <option value="3">Review</option>
                            <option value="3">Suggestion</option>
                        </select>
                    </div>
                    <div class="col-sm-12 col-md-auto col-lg-3">
                        <select class="form-select pdash-form w-100 h-100" aria-label="Default select example">
                            <option selected>Type</option>
                            <option value="1">All</option>
                            <option value="2">Music</option>
                            <option value="3">Tv Show</option>
                            <option value="1">Cinema</option>
                            <option value="2">Theatre</option>
                            <option value="3">Literature</option>
                        </select>
                    </div>
                    <div class="col-sm-12 col-md-auto col-lg-3">
                        <select class="form-select pdash-form w-100 h-100" aria-label="Default select example">
                            <option selected>Date</option>
                        </select>
                    </div>
                    <div class="col-sm-12 col-md-auto col-lg-3">
                        <button class="btn btn-primary pdash-button w-100 h-100" type="button">Filter</button>
                    </div>
                </div>


                <!--Post card -->
                <div class="card"
                    style="max-width: 540px;background-color:#8ab5b1;border:none;">
                    <div class="row d-flex col-12 mx-auto">
                        <div style="padding-right:0;padding-left:0;" class="col-md-4 col-sm-12 pr-0">
                            <img src="images/abs.jpeg" alt="Post title" width="100%" height="100%">
                        </div>
                        <div style="padding-left:0;padding-right:0;" class="col-md-8 col-sm-12 pl-0">
                            <div class="card-body pdash-post-card">
                                <p class="card-text">Title: Mick Jagger celebrates 150...</p>
                                <p class="card-text">Author: Joyce Rodrigues</p>
                                <p class="card-text">Motive: Hate Speech</p>
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <p class="card-text">Reports: 2</p>
                                    </li>
                                    <li class="list-inline-item" style="padding-left:60%;"><img
                                            src="https://static.thenounproject.com/png/1854509-200.png" width="32"
                                            height="32"></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End of Post card -->

            </div>


            <br><br><br><br><br><br><br><br><br><br><br>


        </div>
    </div>

    <!-- SECOND DASH COLUMN-->
    <div class="col-sm-10 col-md-8 col-lg-3 ms-md-5 ps-md-5 mt-5 ml-5">
        <h3 class="text-center" style="font-weight:bold">Unassigned</h3>
        <div class="card" style="background-color:#8ab5b1;border:none;">
            <div class="card-body">
                <div class="row justify-content-center mb-4">
                    <div class="col-sm-12 col-md-auto col-lg-3">
                        <select class="form-select pdash-form w-100 h-100" aria-label="Default select example">
                            <option selected>Category</option>
                            <option value="1">All</option>
                            <option value="2">News</option>
                            <option value="3">Article</option>
                            <option value="3">Review</option>
                            <option value="3">Suggestion</option>
                        </select>
                    </div>
                    <div class="col-sm-12 col-md-auto col-lg-3">
                        <select class="form-select pdash-form w-100 h-100" aria-label="Default select example">
                            <option selected>Type</option>
                            <option value="1">All</option>
                            <option value="2">Music</option>
                            <option value="3">Tv Show</option>
                            <option value="1">Cinema</option>
                            <option value="2">Theatre</option>
                            <option value="3">Literature</option>
                        </select>
                    </div>
                    <div class="col-sm-12 col-md-auto col-lg-3">
                        <select class="form-select pdash-form w-100 h-100" aria-label="Default select example">
                            <option selected>Date</option>
                        </select>
                    </div>
                    <div class="col-sm-12 col-md-auto col-lg-3">
                        <button class="btn btn-primary pdash-button w-100 h-100" type="button">Filter</button>
                    </div>
                </div>


                <!--Post card -->
                <div class="card"
                    style="max-width: 540px;background-color:#8ab5b1;border:none;">
                    <div class="row d-flex col-12 mx-auto">
                        <div style="padding-right:0;padding-left:0;" class="col-md-4 col-sm-12 pr-0">
                            <img src="images/abs.jpeg" alt="Post title" width="100%" height="100%">
                        </div>
                        <div style="padding-left:0;padding-right:0;" class="col-md-8 col-sm-12 pl-0">
                            <div class="card-body pdash-post-card">
                                    <p class="card-text">Title: Hillary Clinton and...</p>
                                    <p class="card-text">Author: Richard Dean</p>
                                    <p class="card-text">Motive: Hate Speech</p>
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <p class="card-text">Reports: 5</p>
                                    </li>
                                    <li class="list-inline-item" style="padding-left:20%;">
                                        <select class="form-select pdash-form-card" aria-label="Default select example">
                                            <option selected>Action</option>
                                            <option value="1">Dismiss Report</option>
                                            <option value="2">Delete Post</option>
                                        </select>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End of Post card -->

            </div>


            <br><br><br><br><br><br><br><br><br><br><br>


        </div>
    </div>
</div>




<!-- End of .container -->
<?php
}
?>
<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AltArt</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/45528450c3.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

    <script src="js/my-profile.js" defer></script>
    <script src="js/settings.js" defer></script>
    <script src="js/user-profile.js" defer></script>
    <script src="js/script.js" defer></script>

    <link rel="stylesheet" href="style/style.css">
</head>

<body>
    <?php
    include_once('./navbar.php');
    draw_navbar("authenticated_user");
    ?>
    <?php
        draw_cdashboard();
    ?>
</body>

</html>