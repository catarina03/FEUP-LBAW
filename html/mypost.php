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

    <link rel="stylesheet" href="style/view_post.css">
    <link rel="stylesheet" href="style/style.css">
    <script src="js/script.js" defer></script>
</head>

<body>

    <?php
    function draw_my_post(){
?>
    <div class="container post">

        <div class="row mt-5 mb-5">
            <div class="card card-post justify-content-center pb-5" style="border-radius:5px;">

                <div class="settings">
                    <i class="fas fa-cog" style="font-size:3em;"></i>
                </div>

                <div class="container-fluid d-flex justify-content-center">
                    <div class="mt-2 col-10 justify-content-center d-flex">
                        <div class="row thumbnail-image">
                            <img src="https://d15v4l58k2n80w.cloudfront.net/file/1396975600/25413991727/width=1600/height=900/format=-1/fit=crop/crop=394x0+6541x3684/rev=3/t=443967/e=never/k=756accaa/Untitled_Panorama6.jpg"
                                class="justify-content-conter" alt="Royal Albert Hall">
                        </div>
                    </div>
                </div>

                <div class="container-fluid d-flex col-10 justify-content-left mt-3">
                    <h1 class="post-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New Video</h1>
                </div>

                <div class="container-fluid d-flex col-10 justify-content-left mt-1">
                    <h2 class="post-author-date">by <a href="./profile.php">Ana Sousa</a>, FEBRUARY 23, 2021</h2>
                </div>

                <div class="container-fluid d-flex col-10 justify-content-left mt-1">
                    <div class="pe-3">
                        <h3 class="post-interactions">4 <i class="far fa-eye"></i></h3>
                    </div>
                    <div class="pe-3">
                        <h3 class="post-interactions">1 <i class="far fa-thumbs-up"></i></h3>
                    </div>
                    <div class="pe-3">
                        <h3 class="post-interactions">0 <i class="far fa-thumbs-down"></i></h3>
                    </div>
                    <div class="pe-3">
                        <h3 class="post-interactions">2 <i class="far fa-comments"></i></h3>
                    </div>
                </div>

                <div class="container-fluid d-flex col-10 justify-content-left mt-2">
                    <p class="post-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in celebration
                        of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes scenes
                        of the empty venue during the pandemic.
                        <br>“I would like to take this opportunity to wish the Royal Albert Hall a very happy 150th
                        birthday and look forward to the future, seeing and listening to many fantastic artists and
                        musicians performing onstage at this iconic venue,” Jagger says.
                        <br>“I have desperately missed live performance — there is something electric and fundamentally
                        human about the shared experience of being in a room surrounded by other people, part of an
                        audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty,
                        but what makes it truly special is the connection it fosters through those shared experiences.
                        That is what this film is about: Not only a celebration of performances from the Hall’s glorious
                        past, but also the sense of anticipation of some of the things to look forward to when we can be
                        together again.”
                        <br>...<br>... <br>“I have desperately missed live performance — there is something electric and
                        fundamentally human about the shared experience of being in a room surrounded by other people,
                        part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when
                        it’s empty, but what makes it truly special is the connection it fosters through those shared
                        experiences. That is what this film is about: Not only a celebration of performances from the
                        Hall’s glorious past, but also the sense of anticipation of some of the things to look forward
                        to when we can be together again.”
                    </p>
                </div>

                <div class="row justify-content-center px-0 mx-0">
                    <div class="col-10">
                        <div class="row justify-content-center px-0 mx-0">
                            <div class="col-auto tag-container p-1 m-1 rounded-3">
                                <a class="post-tag p-2" href=".">Music</a>
                                <i class="far fa-star"></i>
                            </div>
                            <div class="col-auto tag-container p-1 m-1 rounded-3">
                                <a class="post-tag p-2" href=".">News</a><i class="far fa-star"></i>
                            </div>
                            <div class="col-auto tag-container p-1 m-1 rounded-3">
                                <a class="post-tag p-2" href=".">Band</a><i class="far fa-star"></i>
                            </div>
                            <div class="col-auto tag-container p-1 m-1 rounded-3">
                                <a class="post-tag p-2" href=".">Performance</a><i class="far fa-star"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid d-flex col-10 justify-content-center mt-3">
                    <button class="post-thumbs-up-button btn m-2"><i class="far fa-thumbs-up m-0"></i></button>
                    <button class="post-thumbs-down-button btn m-2"><i class="far fa-thumbs-down m-0"></i> </button>
                    <button class="post-report-button btn m-2">Report</button>
                </div>

                <div class="row justify-content-center">
                    <div class="col-10" style="border-radius:5px;">
                        <div class="form-group post-comment-input mb-4">
                            <label class="add-comment-label" for="add-comment">Add comment...</label>
                            <textarea class="container form-control w-100" id="add-comment" rows="3"></textarea>
                            <button class="comment-button btn mt-2">Comment</button>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-10 comment py-3 px-3 mt-1">
                        <div class="row">
                            <div class="d-flex">
                                <h3 class="comment-body">Really good article!</h3>
                                <i class="fas fa-chevron-down ms-auto"></i>
                            </div>
                        </div>
                        <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">João Santos</a>, FEBRUARY 23,
                                2021</h3>
                        </div>
                        <div class="row pt-2">
                            <div class="d-flex">
                                <h3 class="post-interactions pe-3 my-0">1 <i class="far fa-thumbs-up"></i></h3>
                                <h3 class="post-interactions pe-3 my-0">0 <i class="far fa-thumbs-down"></i></h3>
                                <h3 class="post-interactions pe-3 my-0">2 <i class="far fa-comments"></i></h3>
                                <i title="Report comment" class="fas fa-ban my-0 ms-auto"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-10 comment py-3 px-3 mt-1">
                        <div class="row">
                            <div class="d-flex">
                                <h3 class="comment-body">Really good article!</h3>
                                <i class="fas fa-chevron-down ms-auto"></i>
                            </div>
                        </div>
                        <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">Joyce Rodrigues</a>, FEBRUARY 22,
                                2021</h3>
                        </div>
                        <div class="row pt-2">
                            <div class="d-flex">
                                <h3 class="post-interactions pe-3 my-0">1 <i class="far fa-thumbs-up"></i></h3>
                                <h3 class="post-interactions pe-3 my-0">0 <i class="far fa-thumbs-down"></i></h3>
                                <h3 class="post-interactions pe-3 my-0">2 <i class="far fa-comments"></i></h3>
                                <i title="Report comment" class="fas fa-ban my-0 ms-auto"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-10 comment py-3 px-3 mt-1">
                        <div class="row">
                            <div class="d-flex">
                                <h3 class="comment-body">Really good article!</h3>
                                <i class="fas fa-chevron-up ms-auto"></i>
                            </div>
                        </div>
                        <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">Beatrice Layne</a>, FEBRUARY 21,
                                2021</h3>
                        </div>
                        <div class="row pt-2">
                            <div class="d-flex">
                                <h3 class="post-interactions pe-3 my-0">1 <i class="far fa-thumbs-up"></i></h3>
                                <h3 class="post-interactions pe-3 my-0">0 <i class="far fa-thumbs-down"></i></h3>
                                <h3 class="post-interactions pe-3 my-0">2 <i class="far fa-comments"></i></h3>
                                <i title="Report comment" class="fas fa-ban my-0 ms-auto"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-10">
                        <div class="row justify-content-end comment-replies">
                            <div class="col-12 comment-reply reply py-3 px-3">
                                <div class="row">
                                    <div class="d-flex">
                                        <h3 class="comment-body">Agreed!</h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <h4 class="comment-author-date">by <a href="./profile.php">John Doe</a>, FEBRUARY
                                        21, 2021</h3>
                                </div>
                                <div class="row pt-2">
                                    <div class="d-flex">
                                        <h3 class="post-interactions pe-3 my-0">1 <i class="far fa-thumbs-up"></i></h3>
                                        <h3 class="post-interactions pe-3 my-0">0 <i class="far fa-thumbs-down"></i>
                                        </h3>
                                        <h3 class="post-interactions pe-3 my-0">2 <i class="far fa-comments"></i></h3>
                                        <i title="Report comment" class="fas fa-ban my-0 ms-auto"></i>
                                    </div>
                                </div>
                            </div>


                            <div class="col-12 comment-reply-editor">
                                <div class="row">
                                    <div class="d-flex mx-0 px-0">
                                        <textarea class="container form-control w-100" id="add-comment" rows="3"
                                            placeholder="Answer in thread"></textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-auto px-0">
                                        <button class="comment-button btn m-0">Comment</button>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?php
    }
?>


    <?php
        include_once('./navbar.php');
      
        draw_navbar("authenticated_user");

        draw_my_post();
        ?>


</body>


</html>