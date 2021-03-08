<?php 
    function draw_support(){
?>
<!--destaque no titulo,reformatar page e diminuir colunas-->
<script src="js/test.js" defer></script>
<div class="container-md col-lg-8 support-card">
    <section class="text-left faq-rounded" style="background-color:#8ab5b1;">
        <!--Title-->
        <h1 class="text-center support-title">Support</h1>
        <div class="faq_questions">
            <!--Question row-->
            <div class="row px-5 py-3">
                <div class="col-lg-6 question-col">
                    <!--Column with the button needed to make the specified effect in the InVision project-->
                    <div class="form-group">
                        <label for="exampleFormControlTextarea1">Please,tell us more about your problem:</label>
                        <textarea class="form-control" id="support-text" rows="3"></textarea>
                    </div>
                </div>
            </div>
            <div class="row px-5 py-3">
                <div class="col-lg-6 question-col">
                    <div class="form-group">
                        <label for="support-browser">In what browser are you experiencing this problem?</label>
                        <select class="form-control support-form" id="support-browser">
                            <option selected>Choose your browser</option>
                            <option>Google Chrome</option>
                            <option>Firefox Web</option>
                            <option>Safari</option>
                            <option>Microsoft Edge</option>
                            <option>Opera</option>
                        </select>
                    </div>
                </div>
            </div>
            <!-- End of question row-->
            <div class="row px-5 py-3">
                <div class="col-lg-6 question-col">
                    <div class="form-group">
                        <label for="support-browser">How often do you experience this problem?</label>
                        <select class="form-control support-form" id="support-freq">
                            <option selected>Select an option</option>
                            <option>Rarely</option>
                            <option>Often</option>
                            <option>Very Often</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row px-5 py-3">

                <p>How much does this problem impact your experience?</p>
                <div class="col-lg-6 rate-col">

                    <p style="display:inline;padding-right=5%;"> Not much </p>
                    <div class="form-check form-check-inline" style="padding-left:8%;">
                        <input class="form-check-input faq-i" type="radio" name="inlineRadioOptions" id="opt1"
                            value="1">
                        <label class="form-check-label" for="opt1"></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input faq-i" type="radio" name="inlineRadioOptions" id="opt2"
                            value="2">
                        <label class="form-check-label" for="opt2"></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input faq-i" type="radio" name="inlineRadioOptions" id="opt3"
                            value="3">
                        <label class="form-check-label" for="opt3"></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input faq-i" type="radio" name="inlineRadioOptions" id="opt4"
                            value="4">
                        <label class="form-check-label" for="opt4"></label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input faq-i" type="radio" name="inlineRadioOptions" id="opt5"
                            value="5">
                        <label class="form-check-label" for="opt5"></label>
                    </div>
                    <p style="display:inline;"> Very negatively </p>
                    <br><br>
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
        draw_support();
    ?>

    <?php
    include_once('./footer.php');
    draw_footer();
    ?>
</body>

</html>