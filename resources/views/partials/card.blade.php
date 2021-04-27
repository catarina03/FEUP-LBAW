@section('card')
<div class="col-12 col-md-6 col-xl-4 mb-4">
    <div class="card h-100" onclick="window.location='{{url('/post/1')}}'">
        <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
            height="200" class="card-img-top" alt="...">
        <div class="categoryTag">
            <h6>Music</h6>
        </div>
        <div class="savePost" data-toggle="tooltip" data-placement="bottom" title="Save/Unsave Post">
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
            <small>by <a id="authorName" href="{{url('/user/1')}}">Ana
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
@show
