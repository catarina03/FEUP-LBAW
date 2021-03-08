<?php 
    function draw_about(){
?>

<div class="container-md col-lg-8 g-0 about-us-card">
        <div class="row text-left about-rounded justify-content-center" style="background-color:#8ab5b1;border:none;">
            <div class="col-8">
                <h1 class="text-center about-us-title">About Us</h1>
                <div class="card"  style="background-color:#8ab5b1;border:none;">
                    <div class="card-body about-us">
                        <p">We provide a community website where people can connect and talk to one another 
                            about their favourite art-related 
                            topics, keeping everything organized and open to everyone.
                        </p>
                        <ul style="margin-bottom:0;">
                            <p style="margin:0;">Here are some general rules:</p>
                            <li>Do not spam</li>
                            <li>Do not post any fake news</li>
                            <li>Do post any abusive content</li>
                            <li>Do not post any offensive content</li>
                            <p> Any violation to the above rules can be reported,analyzed and deleted by the platform's moderators.</p>
                        </ul>
                    </div>
                </div>
                <h2 class="jusitfy-content-center text-center">Our Team</h2>
                <div class="row py-5 justify-content-center">
                
                    <div class="col-sm-auto">
                        <figure>
                            <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" 
                            width="100" height="100">
                            <figcaption class="text-center">Allan</figcaption>
                        </figure>
                    </div>
                    <div class="col-sm-auto">
                        <figure>
                            <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" 
                            width="100" height="100">
                            <figcaption class="text-center">Catarina</figcaption>
                        </figure>
                    </div>
                    <div class="col-sm-auto">
                        <figure>
                            <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" 
                            width="100" height="100">
                            <figcaption class="text-center">Mariana</figcaption>
                        </figure>
                    </div>
                    <div class="col-sm-auto">
                        <figure>
                            <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" 
                            width="100" height="100">
                            <figcaption class="text-center">Rita</figcaption>
                        </figure>
                    </div>
            </div>
            </div>
        </div>
            
        

  </div>
  <!-- End of .container -->
  <!-- End of .container -->
<?php
}
?>



<!DOCTYPE html>
<html lang="en-US">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style/style.css">
    <script src="js/script.js" defer></script>


    </head>

<body>
    <?php
    include_once('./navbar.php');
    draw_navbar('authenticated_user');
    ?>

    <?php
        draw_about();
    ?>

</body>
</html>
