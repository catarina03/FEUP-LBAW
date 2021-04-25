@extends('layouts.altart-app')

@section('content')
<div class="container about-us-card" style="margin-bottom: 5em;margin-top:4em;">
    <div class="row text-left about-rounded justify-content-center pb-0" style="background-color:#8ab5b1;border:none;">
        <div class="col-lg-9 col-11">
            <h1 class="text-center about-us-title mt-1">About Us</h1>
            <div class="card" style="background-color:#8ab5b1;border:none;">
                <div class="card-body about-us">
                    <p>We provide a community website where people can connect and talk to one another
                        about their favourite art-related
                        topics, keeping everything organized and open to everyone.
                    </p>
                    <p style="margin:0;">Here are some general rules:</p>
                    <ul style="margin-bottom:0;">
                        <li>Do not spam;</li>
                        <li>Do not post any fake news;</li>
                        <li>Do not post any abusive content;</li>
                        <li>Do not post any offensive content;</li>
                    </ul>
                    <p style="margin-top:0.5em;"> Any violation to the above rules can be reported, analyzed and deleted
                        by the platform's
                        moderators.</p>
                </div>
            </div>
            <h2 class="jusitfy-content-center text-center">Our Team</h2>
            <div class="row py-5 justify-content-center">
                <div class="col-sm-auto d-flex justify-content-center">
                    <div class="card" style="width: 10rem;background-color:transparent;border:none;">
                        <img src="./images/allan.jpg"
                             class="card-img-top" alt="Allan Sousa Photo" height="170">
                        <div class="card-body text-center">
                            <p class="card-text mb-0 pb-0">Allan</p>
                            <p class="card-text m-0 p-0"> Sousa</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-auto d-flex justify-content-center">
                    <div class="card" style="width: 10rem;background-color:transparent;border:none;">
                        <img src="./images/catarina.jpg"
                             class="card-img-top" alt="Catarina Fernandes Photo" height="170">
                        <div class="card-body text-center">
                            <p class="card-text mb-0 pb-0">Catarina</p>
                            <p class="card-text m-0 p-0">Fernandes</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-auto d-flex justify-content-center">
                    <div class="card" style="width: 10rem;background-color:transparent;border:none;">
                        <img src="./images/mariana.jpg"
                             class="card-img-top" alt="Mariana Truta Photo" height="170">
                        <div class="card-body text-center">
                            <p class="card-text mb-0 pb-0">Mariana</p>
                            <p class="card-text m-0 p-0"> Truta</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-auto d-flex justify-content-center">
                    <div class="card" style="width: 10rem;background-color:transparent;border:none;">
                        <img src="./images/rita.jfif"
                             class="card-img-top" alt="Rita Peixoto Photo" height="170">
                        <div class="card-body text-center">
                            <p class="card-text mb-0 pb-0">Rita</p>
                            <p class="card-text m-0 p-0"> Peixoto</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection


{{--

<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/45528450c3.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous">
    </script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style/style.css">

</head>

<body class="d-flex flex-column min-vh-100">
<?php
include_once('./navbar.php');
draw_navbar('authenticated_user');
draw_about();
include_once('./mobilebar.php');
draw_mobilebar('authenticated_user');

include_once('./footer.php');
draw_footer();
?>

</body>

</html>
--}}
