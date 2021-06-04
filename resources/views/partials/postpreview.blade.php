<div class="modal fade" id="preview-modal" data-bs-keyboard="false" tabindex="-1"
     aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered justify-content-center d-flex">
        <div class="modal-content">
            {{--
            <div class="modal-header" style="background-color:#307371; color:white;">
                <h5 class="modal-title ">Confirm</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body ms-3">
                <p>Are you sure you want to do this?</p>
            </div>
            <div class="row justify-content-end d-flex me-3 mb-3 ">
                <button type="submit" class="col-2 btn btn-secondary me-4" data-bs-dismiss="modal">No</button>
                <button type="submit" class="col-2 btn custom-button" data-bs-dismiss="modal">Yes</button>
            </div>
            --}}

            <div class="container post">
               {{-- <p hidden id="post_ID">{{$post->id}}</p> --}}
                <p hidden id="user_ID">{{ Auth::user()->id }}</p>
                <div class="row" style="margin-top: 7em; margin-bottom: 7em;">
                    <div class="card post-page-post-card justify-content-center pb-5" style="border-radius:5px;">

                        <div class="container-fluid d-flex justify-content-center">
                            <div class="mt-2 col-10 justify-content-center d-flex">
                                <div class="row thumbnail-image">
                                   {{-- <img src="{{URL::asset($metadata['thumbnail'])}}"
                                         class="justify-content-center" alt="alt src">
                                         --}}
                                    <img src="{{URL::asset('posts/abs.jpeg')}}"
                                         class="justify-content-center" alt="alt src">
                                </div>
                            </div>
                        </div>

                        <div class="container-fluid d-flex col-10 justify-content-left mt-3">
                            {{-- <h1 class="post-page-post-title">{{$post->is_spoiler?"[SPOILER]":""}}{{$post->title}}</h1> --}}
                            <h1 class="post-page-post-title">{{false?"[SPOILER]":""}}TITULO TESTE</h1>
                        </div>

                        <div class="row justify-content-between">
                            <div class="container-fluid d-flex px-0 col-4 mt-1">
                                <h2 class="post-page-post-author-date">by <a
                                    {{-- href="{{route('profile',['id'=>$metadata['author']->id])}}">{{$metadata['author']->name}}</a>, {{$metadata['date']}} --}}
                                    href="{{route('profile',['id'=>Auth::user()->id])}}">{{ Auth::user()->name }}</a>, {{date('Y-m-d H:i:s')}}
                                </h2>
                            </div>

                            <div class="container-fluid d-flex col-2 mt-1">
                                <div class="pe-3">
                                    <h3 class="post-page-post-interactions">0 <i class="far fa-eye"></i>
                                    </h3>
                                </div>
                                <div class="pe-3">
                                    <h3 class="post-page-post-interactions"><span class="up">0 </span> <i class="far fa-thumbs-up"></i></h3>
                                </div>
                                <div class="pe-3">
                                    <h3 class="post-page-post-interactions"><span class="down">0 </span> <i class="far fa-thumbs-down"></i></h3>
                                </div>
                                <div class="pe-3">
                                    <h3 class="post-page-post-interactions"
                                        id="post_comment_count">0 <i class="far fa-comments"></i>
                                    </h3>
                                </div>
                            </div>
                        </div>

                        <div class="container-fluid d-flex col-10 justify-content-left mt-2">
                            <p class="post-page-post-text">CONTEUDO TESTE
                            </p>
                        </div>

                        <div class="row justify-content-center mt-3 mb-3 px-4 mx-1">
                            <div class="col-10">
                                <div class="row justify-content-start align-items-center">
                                    <h2 class="col-auto post-page-post-tags-indicator m-0 p-0">Tags: </h2>
                                    <div class="col-auto post-page-tag-container px-2 m-1">
                                        <a class="post-page-post-tag" href="advanced_search.php">TIPO TESTE</a>
                                    </div>
                                    <div class="col-auto post-page-tag-container px-2 m-1">
                                        <a class="post-page-post-tag" href="advanced_search.php">CATEGORIA TESTE</a>
                                    </div>
                                    {{--
                                    @foreach($metadata['tags'] as $tag)
                                        <div class="col-auto post-page-tag-container px-2 m-1">
                                            <a class="post-page-post-tag" href="advanced_search.php">{{$tag->name}}</a>
                                        </div>
                                    @endforeach
                                    --}}


                                </div>
                            </div>
                        </div>


                        <div class="row justify-content-center mt-5 px-4 mx-1">
                            <div class="col-10 post-comment-indicator">
                                <div class="row justify-content-between align-items-center comment-indicator-row mb-3">
                                    <div class="col-auto m-0 p-0">
                                        <h3 class="mt-0 py-0 mb-1">Comments</h3>
                                    </div>
                                    <div hidden class="col-auto p-0 m-0">
                                        <div class="dropdown p-0 m-0">
                                            <button class="btn btn-secondary dropdown-toggle comment-sort-by-button p-0 m-0"
                                                    type="button" id="comments-sort-by" data-bs-toggle="dropdown"
                                                    aria-expanded="false">Sort by
                                            </button>
                                            <ul class="dropdown-menu comments-sort-by" aria-labelledby="comments-sort-by">
                                                <li><a id="sort_popular" class="dropdown-item">Most popular</a></li>
                                                <li><a id="sort_newest" class="dropdown-item">Newest</a></li>
                                                <li><a id="sort_oldest" class="dropdown-item">Oldest</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <span id="comment-section">

                            <div class="container-fluid d-flex col-10 justify-content-center mt-3">
                                <p><b id="empty-comments">There are no comments in this post. Be the first to leave your thoughts!</b></p>
                            </div>

                        </span>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="modal fade" id="confirm" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered justify-content-center d-flex">
        <div class="modal-content">
            <div class="modal-header" style="background-color:#307371; color:white;">
                <h5 class="modal-title ">Confirm</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body ms-3">
                <p>Are you sure you want to do this?</p>
            </div>
            <div class="row justify-content-end d-flex me-3 mb-3 ">
                <button type="submit" class="col-2 btn btn-secondary me-4" data-bs-dismiss="modal">No</button>
                <button type="submit" class="col-2 btn custom-button" data-bs-dismiss="modal">Yes</button>
            </div>
        </div>
    </div>
</div>

