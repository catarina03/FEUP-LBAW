<div id="topNews" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#topNews" data-bs-slide-to="0" class="active" aria-current="true"
            aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#topNews" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#topNews" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        @for($i = 0; $i < count($posts); $i++) 
            @if($i==0) 
            <div class="carousel-item active">
            @else
            <div class="carousel-item">
            @endif
                <div class="card mb-3" onclick="window.location='/post/{{$posts[$i]->id}}'">
                    <div class="row g-0">
                        <div class="col-md-7">
                            <img src="{{URL::asset($posts[$i]->thumbnail)}}" class="w-100" alt="...">
                        </div>
                        <div class="col-md-5">
                            <div class="card-body">
                                <h5 class="card-title mb-3">{{$posts[$i]->title}}</h5>
                                <p class="card-text d-inline">{{substr($posts[$i]->content, 0, 250) }}</p>
                                <strong> (read more)</strong>
                                <p class="card-text mt-3"><small>by <a href='/user/{{$posts[1]->user_id}}'
                                            id="authorName">{{$posts[$i]->author}}</a>,
                                        {{date("F j, Y", strtotime($posts[$i]->created_at))}}</small></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            @endfor
    </div>
</div>