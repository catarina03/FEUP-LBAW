<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/45528450c3.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"
        integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js"
        integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

    <script src="js/script.js" defer></script>
    <link rel="stylesheet" href="style/style.css">
</head>



<body>
    <?php 
    function draw_dashboard(){
?>

    <div class="moderator row g-0" style="margin-top: 6em; margin-bottom: 7em;">
        <div class="moderator-icon col-12 col-lg-2 pt-lg-5 pt-2 pb-3 text-center justify-content-center">
            <i class="bi bi-people-fill d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
            <h2 style="font-weight:bold;color:#307371;">Moderator Dashboard</h2>
        </div>
        <div class="moderator-center col-12 col-lg-7">

            <div class="postsCards row justify-content-center">
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                            alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small>by <a id="authorName" href="userprofile.php">João
                                    Santos</a>,
                                FEBRUARY 28, 2021</small>

                            <ul class="card-text mt-1 list-unstyled">
                                <li class="pt-1" id="inline-pdash-p"><strong>Author:</strong> João Santos</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Referenced content:</strong> Post</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Motive:</strong> Hate Speech</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Reports:</strong> 300</li>
                            </ul>

                            <div class="text-center">
                                <p class="assign-button" style="font-weight:bold;" data-bs-toggle="modal"
                                    data-bs-target="#confirm">Assign to me</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                            height="200" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small>by <a id="authorName" href="userprofile.php">João
                                    Santos</a>,
                                FEBRUARY 28, 2021</small>

                            <ul class="card-text mt-1 list-unstyled">
                                <li class="pt-1" id="inline-pdash-p"><strong>Author:</strong> Joyce Rodrigues </li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Referenced content:</strong> Comment</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Motive:</strong> Fake News</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Reports:</strong> 212</li>
                            </ul>

                            <div class="text-center">
                                <p class="assign-button" style="font-weight:bold;">Answer Report</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                            alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small>by <a id="authorName" href="userprofile.php">João
                                    Santos</a>,
                                FEBRUARY 28, 2021</small>

                            <ul class="card-text mt-1 list-unstyled">
                                <li class="pt-1" id="inline-pdash-p"><strong>Author:</strong> João Santos</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Referenced content:</strong> Post</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Motive:</strong> Hate Speech</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Reports:</strong> 210</li>
                            </ul>

                            <div class="text-center">
                                <p class="assign-button" style="font-weight:bold;" data-bs-toggle="modal"
                                    data-bs-target="#confirm">Assign to me</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                            height="200" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small>by <a id="authorName" href="userprofile.php">João
                                    Santos</a>,
                                FEBRUARY 28, 2021</small>

                            <ul class="card-text mt-1 list-unstyled">
                                <li class="pt-1" id="inline-pdash-p"><strong>Author:</strong> Joyce Rodrigues </li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Referenced content:</strong> Comment</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Motive:</strong> Fake News</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Reports:</strong> 200</li>
                            </ul>

                            <div class="text-center">
                                <p class="assign-button" style="font-weight:bold;">Answer Report</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                            alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small>by <a id="authorName" href="userprofile.php">João
                                    Santos</a>,
                                FEBRUARY 28, 2021</small>

                            <ul class="card-text mt-1 list-unstyled">
                                <li class="pt-1" id="inline-pdash-p"><strong>Author:</strong> João Santos</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Referenced content:</strong> Post</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Motive:</strong> Hate Speech</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Reports:</strong> 180</li>
                            </ul>

                            <div class="text-center">
                                <p class="assign-button" style="font-weight:bold;" data-bs-toggle="modal"
                                    data-bs-target="#confirm">Assign to me</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                            height="200" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small>by <a id="authorName" href="userprofile.php">João
                                    Santos</a>,
                                FEBRUARY 28, 2021</small>

                            <ul class="card-text mt-1 list-unstyled">
                                <li class="pt-1" id="inline-pdash-p"><strong>Author:</strong> Joyce Rodrigues </li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Referenced content:</strong> Comment</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Motive:</strong> Fake News</li>
                                <li class="pt-1" id="inline-pdash-p"><strong>Reports:</strong> 179</li>
                            </ul>

                            <div class="text-center">
                                <p class="assign-button" style="font-weight:bold;">Answer Report</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-center">
                <div class="pagination">
                    <a href="#">&laquo;</a>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">&raquo;</a>
                </div>
            </div>
        </div>
        <div class="custom-filterBox col-md-3 text-center">
            <div class="container">
                <h4> Filter </h4>
                <form class="pt-2" action="#" method="post">
                    <div class="input-group rounded">
                        <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                            aria-describedby="search-addon" />
                        <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                            <i class="fas fa-search"></i>
                        </span>
                    </div>
                    <select class="form-select mt-4" aria-label="Select a type" style="cursor:pointer;">
                        <option selected>Select a type</option>
                        <option value="1">News</option>
                        <option value="2">Article</option>
                        <option value="3">Review</option>
                        <option value="4">Suggestion</option>
                    </select>
                    <select class="form-select mt-4" aria-label="Select a category" style="cursor:pointer;">
                        <option selected>Select a category</option>
                        <option value="1">Music</option>
                        <option value="2">Cinema</option>
                        <option value="3">TV Show</option>
                        <option value="4">Theatre</option>
                        <option value="5">Literature</option>
                    </select>
                    <select class="form-select mt-4" aria-label="Select date order" style="cursor:pointer;">
                        <option selected>Select date ordering</option>
                        <option value="1">Date: Newer</option>
                        <option value="2">Date: Older</option>
                        <option value="3">Date: Unordered</option>
                    </select>
                    <div class="form-check mt-4">
                        <input class="form-check-input" type="checkbox" value="" id="checkAssigned"
                            style="cursor:pointer;">
                        <label class="form-check-label" for="checkAssigned">
                            Assign to me
                        </label>
                    </div>
                    <div class="form-check mt-4">
                        <input class="form-check-input" type="checkbox" value="" id="checkNotAssigned" style="cursor:pointer;">
                        <label class="form-check-label" for="checkNotAssigned">
                            Unassigned
                        </label>
                    </div>

                    <input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">
                </form>
            </div>
        </div>
    </div>

    <?php
}
?>

    <?php
        include_once('./navbar.php');
        include_once('./confirm.php');

        draw_navbar("authenticated_user");
        draw_dashboard();

        include_once('./mobilebar.php');
        draw_mobilebar("authenticated_user");
    
        include_once('./footer.php');
        draw_footer();
    ?>


</body>


</html>