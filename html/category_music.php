<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <title>AltArt</title>
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
    <!--<div class="col-md-12 col-lg-2">
        <img src="images/music-icon.png" alt="Music icon"> 
        <h1>Music</h1>
    </div>-->
    <div class="container row-2 col-2">
        <figure class="figure">
            <img src="images/books-lbaw-lightblue.svg" class="figure-img img-fluid" alt="Music icon"> 
            <figcaption class="figure-caption">Music</figcaption>
        </figure>
    </div>

    <!--<div class="flex-fill">
    </div>-->
    <?php
        include_once('./footer.php');
        draw_footer();
    ?>
</body>
</html>