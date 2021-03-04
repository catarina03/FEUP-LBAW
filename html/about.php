<?php 
    function draw_about(){
?>

  <div class="container col-12 py-5 about-us-card">
        <section class="text-left" style="background-color:rgb(222, 206, 193);">
            <h1 class="text-center">About Us</h1>
            <p>We provide a community website where people can connect and talk to one another 
                about their favourite art-related 
                topics, keeping everything organized and open to everyone.
            </p>
            <ul>
                <p>Here are some general rules:</p>
                <li>Do not spam</li>
                <li>Do not post any fake news</li>
                <li>Do post any abusive content</li>
                <li>Do not post any offensive content</li><br>
                <p> Any violation to the above rules can be reported,analyzed and deleted by the platform's moderators</p>
            </ul>
            <h2 class="text-center">Our Team</h2>
            <div class="about_image">
                <div class="row py-5 px-auto">
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
            
        </section>
  </div>
  <!-- End of .container -->
<?php
}
?>
<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
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

<body class="d-flex flex-column">
    <?php
    include_once('./navbar.php');
    draw_nav_bar();
    ?>
    <div class="flex-fill">
    <?php
        draw_about();
    ?>
    </div>
    <?php
    include_once('./footer.php');
    draw_footer();
    ?>
</body>
</html>
