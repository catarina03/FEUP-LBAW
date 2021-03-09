<?php 
    function draw_role_manager(){
?>

<div class="container faq-card">
    <section class="text-left faq-rounded" style="background-color:#8ab5b1;">
        <!--Title-->
        <h1 class="text-center faq-title" style="font-weight:bold;">Manage Roles</h1>
        <div class="faq_questions">
            <!--Question row-->
            <div class="row px-5 py-5">
                <!--Column with the button needed to make the specified effect in the InVision project-->
                <div class="col-lg-auto question-col">
                    <div class="btn-group question">
                        <form class="form-inline mt-2 mt-md-0 search-bar" style="display:inline;">
                            <details class="role-det" class="role-manager-detail" open>
                                <summary class="role-sum" style="background-color:#fcf3ee;"><input class="form-control mr-sm-2"
                                        type="text" placeholder="+  Search for username" aria-label="Search"
                                        style="background-color:#fcf3ee;display:inline;boder:none;outline:none;box-shadow:none;">
                                </summary>
                                <p>@ana_sousa<button type="button" class="btn btn-primary sum-inner manager-button"
                                        style="background-color:#fcf3ee;color:black;display:inline-block;margin-left:70%;border:none;">Confirm</button>
                                </p>
                                <p>@ana_sousa<button type="button" class="btn btn-primary sum-inner manager-button"
                                        style="background-color:#fcf3ee;color:black;display:inline-block;margin-left:70%;border:none;">Remove</button>
                                </p>
                                <p>@ana_sousa<button type="button" class="btn btn-primary sum-inner manager-button"
                                        style="background-color:#fcf3ee;color:black;display:inline-block;margin-left:70%;border:none;">Remove</button>
                                </p>
                                <p>@ana_sousa<button type="button" class="btn btn-primary sum-inner manager-button"
                                        style="background-color:#fcf3ee;color:black;display:inline-block;margin-left:70%;border:none;">Remove</button>
                                </p>
                                <p>@ana_sousa<button type="button" class="btn btn-primary sum-inner manager-button"
                                        style="background-color:#fcf3ee;color:black;display:inline-block;margin-left:70%;border:none;">Remove</button>
                                </p>
                            </details>
                        </form>
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

    <link rel="stylesheet" href="style/style.css">
    <script src="js/script.js" defer></script>
</head>

<body>
    <?php
    include_once('./navbar.php');
    include_once('./footer.php');
    draw_navbar("authenticated_user");
    ?>
    <?php
        draw_role_manager();
    ?>
    <?php
        draw_footer();
    ?>
</body>

</html>