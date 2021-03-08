<?php
    function draw_post(){
?>
<div class="container post">

    <div class="row mt-5 mb-5">
        <div class="card card-post justify-content-center pb-5" style="border-radius:1%;">

            <div class="savePost">
                <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
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
                <p class="post-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in celebration of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes scenes of the empty venue during the pandemic.
<br>“I would like to take this opportunity to wish the Royal Albert Hall a very happy 150th birthday and look forward to the future, seeing and listening to many fantastic artists and musicians performing onstage at this iconic venue,” Jagger says.
<br>“I have desperately missed live performance — there is something electric and fundamentally human about the shared experience of being in a room surrounded by other people, part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty, but what makes it truly special is the connection it fosters through those shared experiences. That is what this film is about: Not only a celebration of performances from the Hall’s glorious past, but also the sense of anticipation of some of the things to look forward to when we can be together again.”
<br>...<br>... <br>“I have desperately missed live performance — there is something electric and fundamentally human about the shared experience of being in a room surrounded by other people, part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty, but what makes it truly special is the connection it fosters through those shared experiences. That is what this film is about: Not only a celebration of performances from the Hall’s glorious past, but also the sense of anticipation of some of the things to look forward to when we can be together again.”</p>  
            </div>

            <div class="row">
                <div class="container-fluid d-flex justify-content-center col-md-1 mt-3">
                    <div class="col col-auto tag-container p-1 m-1 rounded-3">
                        <a class="post-tag p-2" href=".">Music</a><i class="far fa-star"></i>
                    </div>
                    <div class="col col-auto tag-container p-1 m-1 rounded-3">
                        <a class="post-tag p-2" href=".">News</a><i class="far fa-star"></i>
                    </div>
                    <div class="col col-auto tag-container p-1 m-1 rounded-3">
                        <a class="post-tag p-2" href=".">Band</a><i class="far fa-star"></i>
                    </div>
                    <div class="col col-auto tag-container p-1 m-1 rounded-3">
                        <a class="post-tag p-2" href=".">Performance</a><i class="far fa-star"></i>
                    </div>
                </div>
            </div>
            

            <div class="container-fluid d-flex col-10 justify-content-center mt-3">
                <button class="post-report-button1 m-2"><i class="far fa-thumbs-up m-2"></i></button>
                <button class="post-report-button1 m-2"><i class="far fa-thumbs-down m-2"></i>  </button>
                <button class="post-report-button1 m-2">Report</button>
            </div>

            <div class="row justify-content-center" >
                <div class="col-10" style="border-radius:2%;">
                    <div class="form-group post-comment-input mb-4">
                        <label class="add-comment-label" for="add-comment">Add comment...</label>
                        <textarea class="container form-control w-100" id="add-comment" rows="3" background-color:green;></textarea>
                        <button class="comment-button m-2">Submit</button>
                    </div> 
                </div>
            </div>

            <div class="row justify-content-center" >
                <div class="col-10 comment py-3 px-3 mt-1" style="border-radius:1%;">
                    <div class="row">
                        <div class="d-flex">
                            <h3 class="comment-body">Really good article!</h3>
                            <i class="fas fa-chevron-down ms-auto"></i>
                        </div>
                    </div>
                    <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">João Santos</a>, FEBRUARY 23, 2021</h3>
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
            <div class="row justify-content-center" >
                <div class="col-10 comment py-3 px-3 mt-1" style="border-radius:1%;">
                    <div class="row">
                        <div class="d-flex">
                            <h3 class="comment-body">Really good article!</h3>
                            <i class="fas fa-chevron-down ms-auto"></i>
                        </div>
                    </div>
                    <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">Joyce Rodrigues</a>, FEBRUARY 22, 2021</h3>
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
            <div class="row justify-content-center" >
                <div class="col-10 comment py-3 px-3 mt-1" style="border-radius:1%;">
                    <div class="row">
                        <div class="d-flex">
                            <h3 class="comment-body">Really good article!</h3>
                            <i class="fas fa-chevron-up ms-auto"></i>
                        </div>
                    </div>
                    <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">Beatrice Layne</a>, FEBRUARY 21, 2021</h3>
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
                        <div class="col-11 comment-reply reply py-3 px-3" style="border-radius:1%;">
                            <div class="row">
                                <div class="d-flex">
                                    <h3 class="comment-body">Really good article!</h3>
                                </div>
                            </div>
                            <div class="row">
                                <h4 class="comment-author-date">by <a href="./profile.php">Beatrice Layne</a>, FEBRUARY 21, 2021</h3>
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

                </div>

            </div>

        </div>
    </div>

</div>

<?php
    }
?>


<?php
    function draw_create_post(){
?>
<div class="container post">

    <div class="row mt-2">
        <div class="card card-post justify-content-center" style="border-radius:1%;">

            <div class="container-fluid d-flex justify-content-center">
                <div class="mt-2 col-10 justify-content-center d-flex">
                    <div class="row thumbnail-image">
                        <h1>Create Post</h1>
                    </div>
                </div>
            </div>



            <div class="container-fluid d-flex col-10 justify-content-left mt-3">
                <div class="new-post-title">
                    <label for="new-post-title">Post title</label>
                    <input type="text" class="form-control" id="new-post-title" placeholder="Title">
                </div>
            </div>


            <div class="container-fluid d-flex col-10 justify-content-left mt-3 align-items-end">
                <div class="row form-group new-post-thumbnail p-1 m-1">
                    <label for="new-post-thumbnail">Post image</label>
                    <input type="file" class="form-control-file" id="new-post-thumbnail">
                </div> 
                <div class="form-group category-dropdown p-1 m-1">
                    <!--<label for="category-dropdown">Category</label>-->
                    <select class="form-control" id="category-dropdown">
                    <option value="" disabled selected hidden>Category</otion>
                    <option>Music</option>
                    <option>Cinema</option>
                    <option>TV Show</option>
                    <option>Theater</option>
                    <option>Literature</option>
                    </select>
                </div>
                <div class="form-group topic-dropdown p-1 m-1">
                    <!--<label for="category-dropdown">Category</label>-->
                    <select class="form-control" id="topic-dropdown">
                    <option value="" disabled selected hidden>Topic</otion>
                    <option>News</option>
                    <option>Article</option>
                    <option>Review</option>
                    <option>Suggestion</option>
                    </select>
                </div>
            </div>           

            <div class="container mt-4 mb-4">
                <div class="row justify-content-md-center">
                    <div class="col-md-12 col-lg-8">
                        <label>Post</label>
                        <div class="form-group">
                            <textarea id="editor"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                        <h5><i class="fas fa-exclamation-triangle"></i> Keep in mind that if your post does not follow all website's rules, it may be reported.</h5>
                    </div>
                </div>
            </div>
           
            <div class="container-fluid d-flex col-10 justify-content-left mt-3">
                <div class="tag-container border p-1 m-1 rounded-3">
                    <a class="post-tag p-2" href=".">Music</a><i class="far fa-star"></i>
                </div>
                <div class="tag-container border p-1 m-1 rounded-3">
                    <a class="post-tag p-2" href=".">News</a><i class="far fa-star"></i>
                </div>
                <div class="tag-container border p-1 m-1 rounded-3">
                    <a class="post-tag p-2" href=".">Band</a><i class="far fa-star"></i>
                </div>
                <div class="tag-container border p-1 m-1 rounded-3">
                    <a class="post-tag p-2" href=".">Performance</a><i class="far fa-star"></i>
                </div>
            </div>
           
            <div class="container-fluid d-flex col-10 justify-content-left mt-3">
                <div class="row form-group post-comment-input">
                            <label for="new-post-title">Title</label>
                            <textarea class="container form-control" id="add-comment" rows="3"></textarea>
                            <button type="submit" class="btn justify-content-left d-flex">Submit</button>
                </div> 
            </div>

            <label for="exampleFormControlInput1">Email address</label>
    <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com">

            <div class="container-fluid d-flex col-10 justify-content-left mt-1">
                <h2 class="post-author-date">by <a href="./profile.php">Ana Sousa</a>, FEBRUARY 23, 2021</h2>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-1">
                <h3 class="post-interactions">4 <i class="far fa-eye"></i>  
                    1 <i class="far fa-thumbs-up"></i>  
                    0 <i class="far fa-thumbs-down"></i>  
                    2 <i class="far fa-comments"></i></h3>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-2">
                <p class="post-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in celebration of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes scenes of the empty venue during the pandemic.
<br>“I would like to take this opportunity to wish the Royal Albert Hall a very happy 150th birthday and look forward to the future, seeing and listening to many fantastic artists and musicians performing onstage at this iconic venue,” Jagger says.
<br>“I have desperately missed live performance — there is something electric and fundamentally human about the shared experience of being in a room surrounded by other people, part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty, but what makes it truly special is the connection it fosters through those shared experiences. That is what this film is about: Not only a celebration of performances from the Hall’s glorious past, but also the sense of anticipation of some of the things to look forward to when we can be together again.”
<br>...<br>... <br>“I have desperately missed live performance — there is something electric and fundamentally human about the shared experience of being in a room surrounded by other people, part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty, but what makes it truly special is the connection it fosters through those shared experiences. That is what this film is about: Not only a celebration of performances from the Hall’s glorious past, but also the sense of anticipation of some of the things to look forward to when we can be together again.”</p>  
            </div>

            <div class="container-fluid d-flex col-10 justify-content-center mt-3">
                <div class="tag-container border p-1 m-1 rounded-3">
                    <a class="post-tag p-2" href=".">Music</a><i class="far fa-star"></i>
                </div>
                <div class="tag-container border p-1 m-1 rounded-3">
                    <a class="post-tag p-2" href=".">News</a><i class="far fa-star"></i>
                </div>
                <div class="tag-container border p-1 m-1 rounded-3">
                    <a class="post-tag p-2" href=".">Band</a><i class="far fa-star"></i>
                </div>
                <div class="tag-container border p-1 m-1 rounded-3">
                    <a class="post-tag p-2" href=".">Performance</a><i class="far fa-star"></i>
                </div>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-center mt-3">
                <button class="post-report-button1 m-2"><i class="far fa-thumbs-up m-2"></i></button>
                <button class="post-report-button1 m-2"><i class="far fa-thumbs-down m-2"></i>  </button>
                <button class="post-report-button1 m-2">Report</button>
            </div>

            <div class="container-fluid d-flex justify-content-center">
                <div class="mt-2 col-10 justify-content-center d-flex">
                    <div class="row form-group post-comment-input">
                            <label for="add-comment">Add comment...</label>
                            <textarea class="container form-control" id="add-comment" rows="3"></textarea>
                            <button type="submit" class="btn justify-content-left d-flex">Submit</button>
                    </div> 
                </div>
            </div>

            <div class="container-fluid comment card card-profile col-10 p-2 m-2 d-flex justify-content-right" style="border-radius:2%;">
                <h3 class="comment-body">Really good article!</h3>
                <h4 class="comment-author-date">by <a href="./profile.php">João Santos</a>, FEBRUARY 23, 2021</h3>
                <h5>1 <i class="far fa-thumbs-up"></i>  
                    0 <i class="far fa-thumbs-down"></i>  
                    1 <i class="far fa-comments"></i>
                    <i class="fas fa-ban d-flex justify-content-right"></i>
                </h5>
            </div>

            <div class="comment card col-10 p-2 m-2 d-flex container justify-content-center" style="border-radius:2%;">
                <h3 class="comment-body">Really good article!</h3>
                <h4 class="comment-author-date">by <a href="./profile.php">João Santos</a>, FEBRUARY 23, 2021</h3>
                <h5>1 <i class="far fa-thumbs-up"></i>  
                    0 <i class="far fa-thumbs-down"></i>  
                    1 <i class="far fa-comments"></i>
                    <i class="fas fa-ban d-flex justify-content-right"></i>
                </h5>
            </div>
            



        </div>
    </div>

</div>

<?php
    }
?>



<?php
    function draw_edit_post(){
?>
<div class="container post">

    <div class="row mt-5 mb-5">
        <div class="card card-post justify-content-center pb-5" style="border-radius:1%;">

            <div class="savePost">
                <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
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
                <p class="post-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in celebration of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes scenes of the empty venue during the pandemic.
<br>“I would like to take this opportunity to wish the Royal Albert Hall a very happy 150th birthday and look forward to the future, seeing and listening to many fantastic artists and musicians performing onstage at this iconic venue,” Jagger says.
<br>“I have desperately missed live performance — there is something electric and fundamentally human about the shared experience of being in a room surrounded by other people, part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty, but what makes it truly special is the connection it fosters through those shared experiences. That is what this film is about: Not only a celebration of performances from the Hall’s glorious past, but also the sense of anticipation of some of the things to look forward to when we can be together again.”
<br>...<br>... <br>“I have desperately missed live performance — there is something electric and fundamentally human about the shared experience of being in a room surrounded by other people, part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty, but what makes it truly special is the connection it fosters through those shared experiences. That is what this film is about: Not only a celebration of performances from the Hall’s glorious past, but also the sense of anticipation of some of the things to look forward to when we can be together again.”</p>  
            </div>

            <div class="row">
                <div class="container-fluid d-flex justify-content-center col-md-1 mt-3">
                    <div class="col col-auto tag-container p-1 m-1 rounded-3">
                        <a class="post-tag p-2" href=".">Music</a><i class="far fa-star"></i>
                    </div>
                    <div class="col col-auto tag-container p-1 m-1 rounded-3">
                        <a class="post-tag p-2" href=".">News</a><i class="far fa-star"></i>
                    </div>
                    <div class="col col-auto tag-container p-1 m-1 rounded-3">
                        <a class="post-tag p-2" href=".">Band</a><i class="far fa-star"></i>
                    </div>
                    <div class="col col-auto tag-container p-1 m-1 rounded-3">
                        <a class="post-tag p-2" href=".">Performance</a><i class="far fa-star"></i>
                    </div>
                </div>
            </div>
            

            <div class="container-fluid d-flex col-10 justify-content-center mt-3">
                <button class="post-report-button1 m-2"><i class="far fa-thumbs-up m-2"></i></button>
                <button class="post-report-button1 m-2"><i class="far fa-thumbs-down m-2"></i>  </button>
                <button class="post-report-button1 m-2">Report</button>
            </div>

            <div class="row justify-content-center" >
                <div class="col-10" style="border-radius:2%;">
                    <div class="form-group post-comment-input mb-4">
                        <label class="add-comment-label" for="add-comment">Add comment...</label>
                        <textarea class="container form-control w-100" id="add-comment" rows="3" background-color:green;></textarea>
                        <button class="comment-button m-2">Submit</button>
                    </div> 
                </div>
            </div>

            <div class="row justify-content-center" >
                <div class="col-10 comment py-3 px-3 mt-1" style="border-radius:1%;">
                    <div class="row">
                        <div class="d-flex">
                            <h3 class="comment-body">Really good article!</h3>
                            <i class="fas fa-chevron-down ms-auto"></i>
                        </div>
                    </div>
                    <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">João Santos</a>, FEBRUARY 23, 2021</h3>
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
            <div class="row justify-content-center" >
                <div class="col-10 comment py-3 px-3 mt-1" style="border-radius:1%;">
                    <div class="row">
                        <div class="d-flex">
                            <h3 class="comment-body">Really good article!</h3>
                            <i class="fas fa-chevron-down ms-auto"></i>
                        </div>
                    </div>
                    <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">Joyce Rodrigues</a>, FEBRUARY 22, 2021</h3>
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
            <div class="row justify-content-center" >
                <div class="col-10 comment py-3 px-3 mt-1" style="border-radius:1%;">
                    <div class="row">
                        <div class="d-flex">
                            <h3 class="comment-body">Really good article!</h3>
                            <i class="fas fa-chevron-up ms-auto"></i>
                        </div>
                    </div>
                    <div class="row">
                            <h4 class="comment-author-date">by <a href="./profile.php">Beatrice Layne</a>, FEBRUARY 21, 2021</h3>
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
                        <div class="col-11 comment-reply reply py-3 px-3" style="border-radius:1%;">
                            <div class="row">
                                <div class="d-flex">
                                    <h3 class="comment-body">Really good article!</h3>
                                </div>
                            </div>
                            <div class="row">
                                <h4 class="comment-author-date">by <a href="./profile.php">Beatrice Layne</a>, FEBRUARY 21, 2021</h3>
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

                </div>

            </div>

        </div>
    </div>

</div>

<?php
    }
?>
