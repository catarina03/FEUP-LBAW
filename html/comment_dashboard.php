<?php 
    function draw_cdashboard(){
?>
    <h1 class="text-center">Dashboard</h1>
    <div class="row">
        <div class="col-sm-1">
            <div style="padding-top:12%;">
                <a href="post_dashboard.php" style="text-decoration:none;color:black;"><p>Posts</p></a>
                <a style="text-decoration:none;"><p style="font-weight:bold;color:black;">Comments</p></a>
            </div>
        </div>
        <div class="col-sm-4 ms-5" >
            <p class="text-center" style="font-weight:bold" >Unassigned</p>
            <div class="card"  style="background-color:#8ab5b1;border:none;">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-auto">
                                <div class="form-group">
                                    <label for="support-browser"></label>
                                    <select class="form-control pdash-form" id="support-browser">
                                        <option selected>Topic</option>
                                        <option>All</option>
                                        <option>Music</option>
                                        <option>Cinema</option>
                                        <option>TV Show</option>
                                        <option>Theatre</option>
                                        <option>Literature</option>
                                    </select>
                                </div> 
                            </div>
                            <div class="col-sm-auto">
                                <div class="form-group">
                                    <label for="support-browser"></label>
                                    <select class="form-control pdash-form" id="support-browser">
                                        <option selected>Category</option>
                                        <option>All</option>
                                        <option>News</option>
                                        <option>Article</option>
                                        <option>Review</option>
                                        <option>Suggestion</option>
                                    </select>
                                </div> 
                            </div>
                            <div class="col-sm-auto">
                                <div class="form-group">
                                    <label for="support-browser"></label>
                                    <select class="form-control pdash-form" id="support-browser">
                                        <option selected>Date</option>
                                        <option>Newer</option>
                                        <option>Older</option>
                                    </select>
                                </div> 
                            </div>
                            <div class="col-sm-auto" style="margin-bottom:0;">
                                <div class="form-group">
                                    <label for="support-browser"></label>
                                    <select class="form-control pdash-form" id="support-browser">
                                        <option selected>Filter</option>
                                    </select>
                                </div> 
                            </div>
                        </div>    
                    </div>
                    <!--Post card -->
                    <div class="card mb-3" style="max-width: 540px;padding-left:2%;background-color:#8ab5b1;border:none;">
                        <div class="row g-0">
                            <div class="col-md-4">
                                <img src="images/abs.jpeg" alt="Post title" width="200px" height="176px">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body pdash-post-card">
                                    <!--<h5 class="card-title">Card title</h5>-->
                                    <p class="card-text">Title: Mick Jagger celebrates 150...</p>
                                    <p class="card-text">Author: Joyce Rodrigues</p>
                                    <p class="card-text">Motive: Hate Speech</p>
                                    <p class="card-text">Reports: 2</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End of Post card -->
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


            </div>
        </div>

        <!-- SECOND DASH COLUMN-->
        <div class="col-sm-4 ms-5" >
            <p class="text-center" style="font-weight:bold">Assigned to me</p>
            <div class="card"  style="background-color:#8ab5b1;border:none;">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-auto">
                                <div class="form-group">
                                    <label for="support-browser"></label>
                                    <select class="form-control pdash-form" id="support-browser">
                                        <option selected>Topic</option>
                                        <option>All</option>
                                        <option>Music</option>
                                        <option>Cinema</option>
                                        <option>TV Show</option>
                                        <option>Theatre</option>
                                        <option>Literature</option>
                                    </select>
                                </div> 
                            </div>
                            <div class="col-sm-auto">
                                <div class="form-group">
                                    <label for="support-browser"></label>
                                    <select class="form-control pdash-form" id="support-browser">
                                        <option selected>Category</option>
                                        <option>All</option>
                                        <option>News</option>
                                        <option>Article</option>
                                        <option>Review</option>
                                        <option>Suggestion</option>
                                    </select>
                                </div> 
                            </div>
                            <div class="col-sm-auto">
                                <div class="form-group">
                                    <label for="support-browser"></label>
                                    <select class="form-control pdash-form" id="support-browser">
                                        <option selected>Date</option>
                                        <option>Newer</option>
                                        <option>Older</option>
                                    </select>
                                </div> 
                            </div>
                            <div class="col-sm-auto">
                                <div class="form-group">
                                    <label for="support-browser"></label>
                                    <select class="form-control pdash-form" id="support-browser">
                                        <option selected>Filter</option>
                                    </select>
                                </div> 
                            </div>
                        </div>    
                    </div>
                <!--Post card -->
                <div class="card mb-3" style="max-width: 540px;padding-left:2%;background-color:#8ab5b1;border:none;">
                        <div class="row g-0">
                            <div class="col-md-4">
                                <img src="images/abs.jpeg" alt="Post title" width="200px" height="176px">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body pdash-post-card">
                                    <!--<h5 class="card-title">Card title</h5>-->
                                    <p class="card-text">Title: Hillary Clinton and...</p>
                                    <p class="card-text">Author: Richard Dean</p>
                                    <p class="card-text">Motive: Hate Speech</p>
                                    <p class="card-text">Reports: 5</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End of Post card -->
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alt Art</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
        integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"
        defer>
    </script>

    <link rel="stylesheet" href="style/custom_navbar.css">
    <link rel="stylesheet" href="style/custom_footer.css">
</head>

<body>
    <?php
    include_once('./navbar.php');
    draw_nav_bar();
    ?>
    <?php
        draw_cdashboard();
    ?>
    <?php
    include_once('./footer.php');
    draw_footer();
    ?>
</body>
</html>
