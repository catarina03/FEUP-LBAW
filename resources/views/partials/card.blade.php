<div class="col-12 col-md-6 col-xl-4 mb-4">
    <div class="card h-100" onclick="window.location = '/post/{{$post->id}}'">

        <img src="{{route('retrieve_post_image',['id'=>$post->id])}}" height="200" class="card-img-top" alt="thumbnail">
        <div>
            @if($post->category == "tv show")
                <a class="black-link categoryTag" href="/category/TVShow">
                    @else
                        <a class="black-link categoryTag" href="/category/{{ucfirst($post->category)}}">
                            @endif
                            <h6>{{ucfirst($post->category)}}</h6>
                        </a>
        </div>


        @auth
            @if($post->user_id != Auth::user()->id)
                <div class="savePost" data-toggle="tooltip" data-placement="bottom" title="Save/Unsave Post">
                    <span class="save_post_id homepage" hidden>{{$post->id}}</span>
                    @if($post->saved == false)
                        <i title="Unsave" class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                    @else
                        <i title="Save" class="bi bi-bookmark-check-fill" style="font-size:3em;"></i>
                    @endif
                </div>
            @else
                <div class="my-post-page-settings btn-group dropdown">
                    <a class="btn fa-cog-icon" data-bs-toggle="dropdown" aria-expanded="false" title="Options">
                        <i title="Settings" class="fas fa-cog" style="font-size:3em;"></i>
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
            @endif
        @endauth
        <div class="infoPosts">
            <i title="Views" class="far fa-eye"></i><span>{{$post->n_views}}</span>
            <i title="Likes" class="far fa-thumbs-up"></i><span>{{$post->likes}}</span>
        </div>
        <div class="card-body">
            <h5 class="card-title">{{$post->title}}
            </h5>
            <small>by <a id="authorName" href='/user/{{$post->user_id}}'>{{$post->author}}</a>, {{date("F j, Y", strtotime($post->created_at))}}</small>
            <p class="card-text" style="text-align: start;">{{Str::limit(wordwrap($post->content, 25),250) }} <strong style="font-size:13px;">(readmore)</strong></p>
        </div>
    </div>
</div>
