
    <div class="col-12 col-md-6 col-xl-4 mb-4">
        <a class=" black-link" href='/post/{{$post->id}}'>
        <div class="card h-100">
            <img src="{{URL::asset($post->thumbnail)}}"
                height="200" class="card-img-top" alt="..."> <!--{{URL::asset($post->thumbnail)}}-->
            <div>
                @if($post->category == "tv show")
                <a class="black-link categoryTag" href="{{ url("category/TVShow") }}">
                @else
                <a class="black-link categoryTag" href="{{ url("category/".ucfirst($post->category)) }}">
                @endif
                    <h6>{{ucfirst($post->category)}}</h6>
                </a>
            </div>
            @auth
                @if($post->user_id == Auth::user()->id)
                        <div class="my-post-page-settings btn-group dropdown">
                            <a class="btn fa-cog-icon" data-bs-toggle="dropdown" aria-expanded="false" title="Options">
                                <i class="fas fa-cog" style="font-size:3em;"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="{{ url("editpost/".$post->id) }}">Edit Post</a>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <a class="dropdown-item" data-bs-toggle="modal"
                                   data-bs-target="#confirm">Delete Post</a>
                            </ul>
                        </div>
                @else
                    <div class="savePost" data-toggle="tooltip" data-placement="bottom" title="Save/Unsave Post">
                        <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                    </div>
                @endif
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



