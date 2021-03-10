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
    <script src="js/advanced_search.js" defer></script>
    <link rel="stylesheet" href="style/style.css">
</head>



<body>
    <?php 
    function draw_dashboard(){
?>

    <div class="category row g-0" style="margin-top: 6em; margin-bottom: 7em;">
        <div class="category-icon col-12 col-lg-2 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
            <img src="images/music.png" class="pb-2" style="width: 40%;">
            <h2 style="font-weight:bold;color:#307371;">Moderator Dashboard</h2>
        </div>
        <div class="category-center col-12 col-lg-7">

            <div class="postsCards row">
                <div class="col-12 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">
                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                            alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        
                        <!--<div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>-->
                        <!--<div class="savePost">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>-->
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small class="text-muted"><!--by <a id="authorName" href="userprofile.php">João
                                    Santos</a>,-->
                                FEBRUARY 28, 2021</small>
                                <p class="card-text mt-3" id="inline-pdash-p">Author: Jõao Santos</p>
                                <p class="card-text mt-3" id="inline-pdash-p">Referenced content: Post</p>
                                <p class="card-text mt-3" id="inline-pdash-p">Motive:  Hate Speech</p>
                                <p class="card-text" id="inline-pdash-p">Reports:  300</p>
                                <p class="card-text text-center" id="pdash-action">Assign to me</p>
                                  
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
                        
                        <!--<div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>-->
                        <!--<div class="savePost">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>-->
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes the Shock'
                                Video </h5>
                            <small class="text-muted"><!--by <a id="authorName" href="userprofile.php">João
                                    Santos</a>,-->
                                FEBRUARY 28, 2021</small>
                                <p class="card-text mt-3" id="inline-pdash-p">Author: Joyce Rodrigues</p>
                                <p class="card-text mt-3" id="inline-pdash-p">Referenced content: Comment</p>
                                <p class="card-text mt-3" id="inline-pdash-p">Motive:  Fake news</p>
                                <p class="card-text" id="inline-pdash-p">Reports:  212</p>
                                <p class="card-text text-center" id="pdash-action">Actions</p>
                                  
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
                        <!--<div class="savePost">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>-->
                        <!--<div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>-->
                        <div class="card-body">
                            <h5 class="card-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New
                                Video
                            </h5>
                            <small class="text-muted">FEBRUARY 23, 2021</small>
                                <p class="card-text mt-3" id="inline-pdash-p">Author: Ana Sousa</p>
                                <p class="card-text mt-3" id="inline-pdash-p">Referenced content: Post</p>
                                <p class="card-text mt-3" id="inline-pdash-p">Motive:  Fake news</p>
                                <p class="card-text" id="inline-pdash-p">Reports:  199</p>
                                <p class="card-text text-center" id="pdash-action">Actions</p>
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
                        <!--<div class="savePost">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>-->
                        <!--<div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>-->
                        <div class="card-body">
                            <h5 class="card-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New
                                Video
                            </h5>
                            <small class="text-muted">FEBRUARY 23, 2021</small>
                                <p class="card-text mt-3" id="inline-pdash-p">Author: James Dean</p>
                                <p class="card-text mt-3" id="inline-pdash-p">Referenced content: Comment</p>
                                <p class="card-text mt-3" id="inline-pdash-p">Motive:  Fake news</p>
                                <p class="card-text" id="inline-pdash-p">Reports:  13</p>
                                <p class="card-text text-center" id="pdash-action">Assign to me</p>
                        </div>
                    </div>
                </div>
                
                
            </div>
        </div>
        <div class="category-filter col-md-3 text-center">
            <div class="container">
                <h4> Search </h4>
                <form class="pt-2" action="post_dashboard.php" method="post">
                    <div class="input-group rounded">
                        <!--<input type="search" class="form-control" placeholder="Search" aria-label="Search"
                            aria-describedby="search-addon" />
                        <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                            <i class="fas fa-search"></i>
                        </span>-->
                    </div>
                    <select class="form-select mt-4" aria-label="Select a type">
                        <option selected>Select a type</option>
                        <option value="1">All</option>
                        <option value="2">News</option>
                        <option value="3">Article</option>
                        <option value="4">Review</option>
                        <option value="5">Suggestion</option>
                    </select>
                    <select class="form-select mt-4" aria-label="Select a type">
                        <option selected>Select type of content</option>
                        <option value="1">All</option>
                        <option value="2">Posts</option>
                        <option value="3">Comments</option>
                    </select>
                    <select class="form-select mt-4" aria-label="Select date order">
                        <option selected>Select date ordering</option>
                        <option value="1">Date: Newer</option>
                        <option value="2">Date: Older</option>
                        <option value="3">Date: Unordered</option>
                    </select>

                    <div class="form-check mt-4">
                        <input class="form-check-input" type="checkbox" value="" id="checkPeople">
                        <label class="form-check-label" for="checkPeople">
                            Assigned to me
                        </label>
                    </div>
                    <div class="form-check mt-4">
                        <input class="form-check-input" type="checkbox" value="" id="checkTags">
                        <label class="form-check-label" for="checkTags">
                            Unassigned
                        </label>
                    </div>

                    <input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">
                </form>
            </div>
        </div>
    </div>

    <footer class="bottomNavbar d-lg-none">
        <div id="buttonGroup" class="btn-group selectors" role="group" aria-label="Mobile Navbar">
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
        draw_dashboard();

        include_once('./mobilebar.php');
        draw_mobilebar();
    
        include_once('./footer.php');
        draw_footer();
    ?>


</body>


</html>