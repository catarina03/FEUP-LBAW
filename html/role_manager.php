<?php 
    function draw_role_manager(){
?>

  <div class="container-md col-lg-6 col-sm-10 faq-card">
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
                                 <details class="role-manager-detail" open>
                                    <summary style="background-color:#fcf3ee;"><input class="form-control mr-sm-2" type="text"
                                        placeholder="+  Search for username" aria-label="Search" 
                                        style="background-color:#fcf3ee;display:inline;boder:none;outline:none;box-shadow:none;">
                                    </summary>
                                    <p>@ana_sousa</p>
                                    <p>@ana_sousa</p>
                                    <p>@ana_sousa</p>
                                    <p>@ana_sousa</p>
                                    <p>@ana_sousa</p>
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
        draw_role_manager();
    ?>
    </div>
    <?php
    include_once('./footer.php');
    draw_footer();
    ?>
</body>
</html>
