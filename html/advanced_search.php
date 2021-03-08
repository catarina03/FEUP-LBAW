<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Advanced Search</title>
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
    <script src="js/advanced_search.js" defer></script>
    <link rel="stylesheet" href="style/style.css">
</head>



<body>
    <?php 
    function draw_advanced_search(){
?>

    <div class="advanced_search row g-0 mb-5" style="margin-top: 5em;">
        <div class="advancedSearch-icon col-12 col-lg-3 pt-4 ps-5 pe-5 text-center flex-column">
            <i class="bi bi-search d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
            <h2 style="font-weight:bold;color:#307371;">Advanced Search</h2>
        </div>
        <div class="advanced_search-center mt-4 col-12 col-lg-7">
            <form class="rowFilter row g-3">
                <div class="col-12 input-group rounded">
                    <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                        aria-describedby="search-addon" />
                    <span class="input-group-text border-0" id="search-addon"
                        style="background-color:black;color:#fcf3ee;">
                        <i class="fas fa-search"></i>
                    </span>
                </div>

                <div class="col-md-6 filter d-none">
                    <label for="validationDefault04" class="form-label">Category</label>
                    <select class="form-select" id="validationDefault04" required>
                        <option selected value="">Select a category</option>
                        <option value="1">Music</option>
                        <option value="2">Cinema</option>
                        <option value="3">TV Show</option>
                        <option value="4">Theatre</option>
                        <option value="5">Literature</option>
                    </select>
                </div>
                <div class="col-md-6 filter d-none">
                    <label for="validationDefault04" class="form-label">Type</label>
                    <select class="form-select" id="validationDefault04" required>
                        <option selected value="">Select a type</option>
                        <option value="1">News</option>
                        <option value="2">Article</option>
                        <option value="3">Review</option>
                        <option value="4">Suggestion</option>
                    </select>
                </div>

                <div class="col-md-6 filter d-none">
                    <label for="validationDefault03" class="form-label">Start Date</label>
                    <input type="date" class="form-control" id="startDate" aria-label="Start Date">
                </div>
                <div class="col-md-6 filter d-none">
                    <label for="validationDefault03" class="form-label">End Date</label>
                    <input type="date" class="form-control" id="startDate" aria-label="End Date">
                </div>
                <div class="col-6 filter d-none">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="checkPeople">
                        <label class="form-check-label" for="checkPeople">
                            Only people I follow
                        </label>
                    </div>
                </div>
                <div class="col-6 filter d-none">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="checkTags">
                        <label class="form-check-label" for="checkTags">
                            Only tags I follow
                        </label>
                    </div>
                </div>
                <div class="col-12 d-flex justify-content-end fs-5">
                    <button class="filterButton p-5 pt-2 pb-2" type="submit">Search</button>
                </div>
                <div class="col-12 d-flex justify-content-end fs-5">
                    <a href="#" style="color:black;" class="d-flex arrowButton arrow-down"><i
                            class="bi bi-arrow-down-square-fill"></i></a>
                    <a href="#" style="color:black;" class="d-none arrowButton arrow-up"><i
                            class="bi bi-arrow-up-square-fill"></i></a>
                </div>
            </form>
            <p class="pt-4 ps-4 fs-4">4 results found!</p>
            <div class="postsCards row mt-3">
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                            alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="savePost">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small class="text-muted">by <a id="authorName" href="https://www.google.com/">João
                                    Santos</a>,
                                FEBRUARY 28, 2021</small>
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                            height="200" class="card-img-top" alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        <div class="savePost">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>
                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New
                                Video
                            </h5>
                            <small class="text-muted">by <a id="authorName" href="https://www.google.com/">Ana
                                    Sousa</a>,
                                FEBRUARY 23, 2021</small>
                            <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in
                                celebration
                                of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film
                                includes
                                scenes
                                of the empty venue during the pandemic. "I would like to take this <strong>(read
                                    more)</strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHw%3D&w=1000&q=80"
                            height="200" class="card-img-top" alt="...">
                        <div class="categoryTag">
                            <h6>Literature</h6>
                        </div>
                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="savePost">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Hillary Clinton and Louise Penny to Write Political Thriller</h5>
                            <small class="text-muted">by <a id="authorName" href="https://www.google.com/">Alexandra
                                    Alter</a>,
                                FEBRUARY 23, 2021</small>
                            <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in
                                celebration
                                of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film
                                includes
                                scenes
                                of the empty venue during the pandemic. "I would like to take this <strong>(read
                                    more)</strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                            alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="savePost">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small class="text-muted">by <a id="authorName" href="https://www.google.com/">João
                                    Santos</a>,
                                FEBRUARY 28, 2021</small>
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe. The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bottomNavbar d-lg-none">
        <div id="buttonGroup" class="btn-group selectors" role="group" aria-label="Basic example">
            <button id="home" type="button" class="btn button-active">
                <div class="selector-holder">
                    <i class="bi bi-house fs-2"></i>
                    <p>Home</p>
                </div>
            </button>
            <button id="feed" type="button" class="btn button-inactive">
                <div class="selector-holder">
                    <i class="bi bi-plus fs-2"></i>
                    <p>Create</p>
                </div>
            </button>
            <button id="create" type="button" class="btn button-inactive">
                <div class="selector-holder">
                    <i class="bi bi-bell fs-2"></i>
                    <p>Notifications</p>
                </div>
            </button>
            <button id="account" type="button" class="btn button-inactive">
                <div class="selector-holder">
                    <i class="bi bi-person-circle fs-2"></i>
                    <p>@ana_sousa</p>
                </div>
            </button>
        </div>
    </footer>

    <?php
}
?>
    <?php
        include_once('./navbar.php');
        draw_navbar("authenticated_user");
        draw_advanced_search();
    ?>


</body>


</html>