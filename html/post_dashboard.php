<?php 
    function draw_pdashboard(){
?>
    <h1 class="text-center mt-3" >Dashboard</h1>
    <div class="row justify-content-center">


        <div class="col-1 ms-1 d-lg-flex d-md-none d-sm-none d-xs-none settings-vertical">
            <div style="padding-top:12%;">
                <img src="images/postIcon.png" width="50" heigth="50"><a style="text-decoration:none;"><p style="font-weight:bold;color:black;display:inline;">Posts</p></a>  
                <img src="images/commentIcon.png" width="50" heigth="50"><a href="comment_dashboard.php" style="text-decoration:none;color:black;"><p style="display:inline;">Comments</p></a>
            </div>
        </div>
        <div class="col-12 justify-content-center d-sm-flex d-lg-none d-md-flex settings-horizontal">
            <div class="row justify-content-center">
                <div class="col-4">
                    <a style="text-decoration:none;"><p style="font-weight:bold;color:black;">Posts</p></a> 
                </div>
                <div class="col-4">
                <a href="comment_dashboard.php" style="text-decoration:none;color:black;"><p>Comments</p></a>
                </div>
            </div>
        </div>









        <div class="col-sm-4 ms-4" >
            <h3 class="text-center" style="font-weight:bold" >Unassigned</h3>
            <div class="card"  style="background-color:#8ab5b1;border:none;">
                    <div class="card-body">
                        <div class="row justify-content-center">
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
                            <div class="col-sm-auto" >
                                <br>
                                <button class="btn btn-primary pdash-button" type="button">Filter</button>
                            </div>
                        </div>    
                        <!--Post card -->
                        <div class="card mb-3" style="max-width: 540px;margin: 0 auto;padding-top:5%;background-color:#8ab5b1;border:none;">
                            <div class="row  g-0">
                                <div class="col-md-4 col-sm-12">
                                    <img src="images/abs.jpeg" alt="Post title" width="200px" height="176px">
                                </div>
                                <div class="col-md-8 col-sm-12">
                                    <div class="card-body pdash-post-card">
                                        <!--<h5 class="card-title">Card title</h5>-->
                                        <p class="card-text">Title: Mick Jagger celebrates 150...</p>
                                        <p class="card-text">Author: Ana Sousa</p>
                                        <p class="card-text">Motive: Hate Speech</p>
                                        <p class="card-text">Reports: 329</p>
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
        <div class="col-sm-4 ms-4" >
            <h3 class="text-center" style="font-weight:bold">Assigned to me</h3>
            <div class="card"  style="background-color:#8ab5b1;border:none;">
                    <div class="card-body">
                        <div class="row justify-content-center">
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
                                <br>
                                <button class="btn btn-primary pdash-button" type="button">Filter</button>
                            </div>
                        </div>    
                        <!--Post card -->
                        <div class="card mb-3" style="max-width: 540px;margin:0 auto;padding-top:5%;background-color:#8ab5b1;border:none;">
                            <div class="row g-0">
                                <div class="col-md-4">
                                    <img src="images/abs.jpeg" alt="Post title" width="200px" height="176px">
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body pdash-post-card">
                                        <!--<h5 class="card-title">Card title</h5>-->
                                        <p class="card-text">Title: Hillary Clinton and...</p>
                                        <p class="card-text">Author: Alexandra Alter</p>
                                        <p class="card-text">Motive: Fake News</p>
                                        <p class="card-text">Reports: 5</p>
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
        draw_pdashboard();
    ?>
    <?php
    include_once('./footer.php');
    draw_footer();
    ?>
</body>
</html>
