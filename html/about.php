<?php 
    function draw_about(){
?>

  <div class="container-md col-lg-8 about-us-card">
        <section class="text-left about-rounded" style="background-color:#8ab5b1;">
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
            <h2 class="text-center">Our Team</h2>
            <div class="about_image">
                <div class="row py-5 px-auto">
                    <div class="col-sm-auto">
                        <figure>
                            <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" 
                            width="100" height="100">
                            <figcaption class="text-left">Allan</figcaption>
                        </figure>
                    </div>
                    <div class="col-sm-auto">
                        <figure>
                            <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" 
                            width="100" height="100">
                            <figcaption class="text-left">Catarina</figcaption>
                        </figure>
                    </div>
                    <div class="col-sm-auto">
                        <figure>
                            <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" 
                            width="100" height="100">
                            <figcaption class="text-left">Mariana</figcaption>
                        </figure>
                    </div>
                    <div class="col-sm-auto">
                        <figure>
                            <img src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" 
                            width="100" height="100">
                            <figcaption class="text-left">Rita</figcaption>
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AltArt</title>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet"> 
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
        integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"
        defer>
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/45528450c3.js" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        

        <script src="https://cdn.tiny.cloud/1/08t5y62wss6y2fzascz2trysrq487403jdb54o0kzk3nu9zq/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
        tinymce.init({
            selector: '#mytextarea'

        });
        </script>

        <script src="js/my-profile.js" defer></script>
        <script src="js/settings.js" defer></script>
        <script src="js/user-profile.js" defer></script>
        

        <link rel="stylesheet" href="style/custom_navbar.css">
        <link rel="stylesheet" href="style/view_post.css">
        <link rel="stylesheet" href="style/homepage.css">
        <link rel="stylesheet" href="style/style.css">
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
