
    <div class="col-12 col-md-6 col-xl-4 mb-4">
        <a class=" black-link" href='/post/{{$post->id}}'>
        <div class="card h-100">
            <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                height="200" class="card-img-top" alt="..."> <!--{{URL::asset($post->thumbnail)}}-->
            <div>
                <a class="black-link categoryTag" href="category/{{ucfirst($post->category)}}">
                    <h6>{{ucfirst($post->category)}}</h6>
                </a>
            </div>
            @auth
            <div class="savePost" data-toggle="tooltip" data-placement="bottom" title="Save/Unsave Post">
                <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
            </div>
            @endauth
            <div class="infoPosts">
                <i class="far fa-eye"></i><span>{{$post->n_views}}</span>
                <i class="far fa-thumbs-up"></i><span>{{$post->likes}}</span>
            </div>
            <div class="card-body">
                <h5 class="card-title">{{$post->title}}
                </h5>
                <small>by <a id="authorName" href='/user/{{$post->user_id}}'>{{$post->author}}</a>, {{date("F j, Y", strtotime($post->created_at))}}</small>
                <p class="card-text">{{substr($post->content, 0, 250)}}<strong>(readmore)</strong></p>
                </div>
        </div>
    </div>



