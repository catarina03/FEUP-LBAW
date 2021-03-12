<?php 
    function draw_support(){
?>
<!--destaque no titulo,reformatar page e diminuir colunas-->
<div class="container support-card" style="margin-bottom: 5em; margin-top: 5em;">
    <section class="text-left faq-rounded" style="background-color:#8ab5b1;">
        <!--Title-->
        <h1 class="text-center support-title">Support</h1>
        <div class="row faq_questions justify-content-center">
            <div class="col-lg-9 col-11 mb-4">
                <!--Question row-->
                <div class="row pb-4">
                    <div class="col-lg-6 question-col">
                        <!--Column with the button needed to make the specified effect in the InVision project-->
                        <div class="form-group">
                            <label for="exampleFormControlTextarea1">Please, tell us more about your problem:</label>
                            <textarea class="form-control mt-2" id="support-text" rows="3" style="resize:none;"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row pb-4">
                    <div class="col-lg-6 question-col">
                        <div class="form-group">
                            <label for="support-browser">In what browser are you experiencing this problem?</label>
                            <select class="form-select support-form mt-2" id="support-browser">
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
                <div class="row pb-4">
                    <div class="col-lg-6 question-col">
                        <div class="form-group">
                            <label for="support-browser">How often do you experience this problem?</label>
                            <select class="form-select support-form mt-2" id="support-freq">
                                <option selected>Select an option</option>
                                <option value="1">Rarely</option>
                                <option value="2">Often</option>
                                <option value="3"> Very Often</option>
                            </select>
                            <label class="mt-5" for="support-browser">How much does this problem impact your
                                experience?</label>
                        </div>
                    </div>
                </div>


                <div class="row pb-4 justify-content-center">
                    <div class="col-lg-4 col-sm-12 rate-col">
                        <p class="sm-paragraph d-md-none d-lg-none" style="text-center;padding-left:30%;"> Not much </p>
                        <p class="md-paragraph" style="padding-right:0;"> Not much </p>
                    </div>

                    <div class="col-lg-4 col-sm-12 rate-col-radio">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input inner faq-i" type="radio" name="inlineRadioOptions" id="opt1"
                                value="1">
                            <label class="form-check-label" for="opt1"></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input inner faq-i" type="radio" name="inlineRadioOptions" id="opt2"
                                value="2">
                            <label class="form-check-label" for="opt2"></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input inner faq-i" type="radio" name="inlineRadioOptions" id="opt3"
                                value="3">
                            <label class="form-check-label" for="opt3"></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input inner faq-i" type="radio" name="inlineRadioOptions" id="opt4"
                                value="4">
                            <label class="form-check-label" for="opt4"></label>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-12 rate-col">
                        <p class="sm-paragraph-2 d-md-none d-lg-none" style="text-center;padding-left:30%;"> Very
                            Negatively
                        </p>
                        <p class="md-paragraph-2"> Very Negatively </p>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <a href="homepage.php" class="btn support-button"
                        type="button">Submit</a>
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
    <title>Support</title>
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
    <script src="js/script.js" defer></script>
    <script src="js/test.js" defer></script>

</head>

<body class="d-flex flex-column min-vh-100">
    <?php
    include_once('./navbar.php');
    
    draw_navbar('authenticated_user');
    draw_support();
    include_once('./mobilebar.php');
    draw_mobilebar();

    include_once('./footer.php');
    draw_footer();
?>
</body>

</html>