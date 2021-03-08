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
                            <details>
                                <summary class="text-center">Why do I need to make an account?</summary>
                                <p>Even though you can view all posts without an account, you need and
                                account in order to be able to comment,like,dislike,follow other users and follow your favorite tags.</p>
                            </details>
                        </div>
                    </div>    
                </div>
                <div class="row py-5">
                    <!--Column with the button needed to make the specified effect in the InVision project-->
                    <div class="col-lg-6 question-col">
                        <div class="btn-group question justify-content-center">
                            <details>
                                <summary class="text-center">How can I report a  comment  or  post?</summary>
                                <p>Very nice explanation...</p>
                            </details>    
                        </div>
                    </div>    
                </div>
                <!-- End of question row-->
                <div class="row py-5">
                    <div class="col-lg-6 question-col">
                        <div class="btn-group question justify-content-center">
                            <details>
                                    <summary class="text-center">Can I recover a deleted post or comment?</summary>
                                    <p>Very nice explanation...</p>
                            </details>
                        </div>
                    </div>
                </div>
                <div class="row py-5">
                    <div class="col-lg-6 question-col">
    
                        <div class="btn-group question justify-content-center">
                            <details>
                                <summary class="text-center">What happens to a post that gets reported?</summary>
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
        draw_faq();
    ?>
    <?php
    include_once('./footer.php');
    draw_footer();
    ?>
</body>
</html>
