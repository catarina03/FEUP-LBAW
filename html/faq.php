<?php 
    function draw_faq(){
?>
<div class="container-md col-lg-8 col-sm-10 faq-card">
    <section class="text-left faq-rounded" style="background-color:#8ab5b1;">
        <!--Title-->
        <h1 class="text-center faq-title" style="font-weight:bold;">Frequently Asked Questions</h1>
        <div class="faq_questions">
            <!--Question row-->
            <div class="row py-5">
                <!--Column with the button needed to make the specified effect in the InVision project-->
                <div class="col-lg-6 question-col">
                    <div class="btn-group question justify-content-center">
                        <details class="faq-det">
                            <summary class="text-center faq-sum">Why do I need to make an account?</summary>
                            <p>Even though you can view all posts without an account, you need and
                                account in order to be able to comment,like,dislike,follow other users and follow your
                                favorite tags.</p>
                        </details>
                    </div>
                </div>
            </div>
            <div class="row py-5">
                <!--Column with the button needed to make the specified effect in the InVision project-->
                <div class="col-lg-6 question-col">
                    <div class="btn-group question justify-content-center">
                        <details class="faq-det">
                            <summary class="text-center faq-sum">How can I report a comment or post?</summary>
                            <p>Very nice explanation...</p>
                        </details>
                    </div>
                </div>
            </div>
            <!-- End of question row-->
            <div class="row py-5">
                <div class="col-lg-6 question-col">
                    <div class="btn-group question justify-content-center">
                        <details class="faq-det">
                            <summary class="text-center faq-sum">Can I recover a deleted post or comment?</summary>
                            <p>Very nice explanation...</p>
                        </details>
                    </div>
                </div>
            </div>
            <div class="row py-5">
                <div class="col-lg-6 question-col">

                    <div class="btn-group question justify-content-center">
                        <details class="faq-det">
                            <summary class="text-center faq-sum">What happens to a post that gets reported?</summary>
                            <p>The post will be marked, one of the moderators is going to
                                analyze your post and decide if it indeed breaks the rules of the site.</p>
                        </details>
                    </div>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

    <script src="js/my-profile.js" defer></script>
    <script src="js/settings.js" defer></script>
    <script src="js/user-profile.js" defer></script>
    <script src="js/script.js" defer></script>

    <link rel="stylesheet" href="style/view_post.css">
    <link rel="stylesheet" href="style/style.css">

</head>

<body>
    <?php
    include_once('./navbar.php');
    draw_navbar("authenticated_user");
    ?>
    <?php
        draw_faq();
    ?>
    <?php
    include_once('./footer.php');
    draw_footer();
    ?>
</body>

</html>