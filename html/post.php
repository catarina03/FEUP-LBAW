<?php
    function draw_post(){
?>
<div class="container post">

    <div class="row mt-2">
        <div class="card card-post justify-content-center" style="border-radius:1%;">

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