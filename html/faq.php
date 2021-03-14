<?php 
    function draw_faq(){
?>
<div class="container faq-card col-lg-8 col-sm-12"style="" >
    <div class="col-12 text-left " style="background-color:#8ab5b1;border-radius:2%;min-height:800px;">
        <h1 class="text-center faq-title ">Frequently Asked Questions</h1>
        <!--Title-->
        <div class="row justify-content-center pt-4 pb-4">
            <div class="faq_questions col-lg-9 col-11">
                <!--Question row-->
                <div class="question mt-5">
                    <div class="question-text p-1">
                        <h4> Why do I need to create an account? </h4>
                    </div>
                    <div class="answer fs-4">
                        <p> Even though you can view all posts without an account, you need one in order to be able to comment, like, dislike, follow other users and follow your
                            favorite tags. </p>
                    </div>
                </div>
                <div class="question  mt-5">
                    <div class="question-text p-1">
                        <h4> How can I report a comment or post? </h4>
                    </div>
                    <div class="answer fs-4">
                        <p> Very nice explanation... </p>
                    </div>
                </div>

                <div class="question  mt-5">
                    <div class="question-text p-1">
                        <h4> What happens to a post that gets reported? </h4>
                    </div>
                    <div class="answer fs-4">
                        <p> The post will be marked, one of the moderators is going to
                            analyze it and decide if it indeed breaks the rules of the site.
                        </p>
                    </div>
                </div>
                <div class="question  mt-5">
                    <div class="question-text p-1">
                        <h4> Where can I change my preferences? </h4>
                    </div>
                    <div class="answer fs-4">
                        <p> On users' profile, in settings 
                        </p>
                    </div>
                </div>


            </div>
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
    <title>FAQ</title>
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
    draw_navbar("visitor");
    draw_faq();
    include_once('./mobilebar.php');
    draw_mobilebar();

    include_once('./footer.php');
    draw_footer();
    ?>
</body>

</html>