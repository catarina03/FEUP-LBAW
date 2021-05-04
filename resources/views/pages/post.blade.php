@include('pages.confirm')
@extends('layouts.app')

@section('content')
<script type="text/javascript" src="{{ URL::asset('js/delete_confirm.js') }}" defer></script>
<script type="text/javascript" src="{{ URL::asset('js/save_post.js') }}" defer></script>
<script type="text/javascript" src="{{ URL::asset('js/add_comment.js') }}" defer></script>
<div class="container post">
    <p hidden id="post_ID">{{$post->id}}</p>
    <p hidden id="user_ID">{{$user_id}}</p>
    <div class="row" style="margin-top: 7em; margin-bottom: 7em;">
        <div class="card post-page-post-card justify-content-center pb-5" style="border-radius:5px;">

            @if($user!="visitor")
                @if($user=='authenticated_owner'){{-- Se for o próprio owner a ver --}}
                <div class="my-post-page-settings btn-group dropdown">
                    <a class="btn fa-cog-icon" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-cog" style="font-size:3em;"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <a class="dropdown-item" href="editpost.php">Edit Post</a>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <a class="dropdown-item" data-bs-toggle="modal"
                           data-bs-target="#confirm">Delete Post</a>
                    </ul>
                </div>
                @else
                    <div class="post-page-save-post-bookmark savePost">
                        <i class="bi bi-bookmark-plus-fill" title="Save/unsave post" style="font-size:3em; cursor:pointer;"></i>
                    </div>
                @endif
            @endif

            <div class="container-fluid d-flex justify-content-center">
                <div class="mt-2 col-10 justify-content-center d-flex">
                    <div class="row thumbnail-image">
                        <img src="{{URL::asset($metadata['thumbnail'])}}"
                             class="justify-content-conter" alt="alt src">
                    </div>
                </div>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-3">
                <h1 class="post-page-post-title">{{$post->title}}</h1>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-1">
                <h2 class="post-page-post-author-date">by <a href="./myprofile.php">{{$metadata['author']}}</a>, {{$metadata['date']}}</h2>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-1">
                <div class="pe-3">
                    <h3 class="post-page-post-interactions">{{$metadata['views']}} <i class="far fa-eye"></i></h3>
                </div>
                <div class="pe-3">
                    <h3 class="post-page-post-interactions">{{$metadata['likes']}} <i class="far fa-thumbs-up"></i></h3>
                </div>
                <div class="pe-3">
                    <h3 class="post-page-post-interactions">0 <i class="far fa-thumbs-down"></i></h3>
                </div>
                <div class="pe-3">
                    <h3 class="post-page-post-interactions">{{$metadata['comment_count']}} <i class="far fa-comments"></i></h3>
                </div>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-2">
                <p class="post-page-post-text">{{$post['content']}}
                </p>
            </div>

            <div class="row justify-content-center mt-3 mb-3 px-4 mx-1">
                <div class="col-10">
                    <div class="row justify-content-start align-items-center">
                        <h2 class="col-auto post-page-post-tags-indicator m-0 p-0">Tags: </h2>

                        @foreach($metadata['tags'] as $tag)
                            <div class="col-auto post-page-tag-container px-2 m-1">
                                <a class="post-page-post-tag" href="advanced_search.php">{{$tag->name}}</a>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>

                @if($user=="authenticated_user") {{-- User is not the owner of the post --}}
            <div class="row justify-content-center mt-3 px-4 mx-1">
                <div class="col-10 mx-0 px-0">
                    <div class="row justify-content-start align-items-center px-0 mx-0">
                        <div class="col-auto px-0 mx-0">
                            <button class="post-page-post-thumbs-up-button btn ms-0 me-4 px-0"><i title="Like post" class="far fa-thumbs-up m-0"></i></button>
                        </div>
                        <div class="col-auto px-0 mx-0">
                            <button class="post-page-post-thumbs-down-button btn ms-0 me-4 px-0"><i title="Dislike post" class="far fa-thumbs-down m-0"></i></button>
                        </div>
                        <div class="col-auto px-0 mx-0 ms-auto">
                            <button class="post-page-post-report-button btn ms-0 me-0 py-0 px-0"><i title="Report post" class="fas fa-ban m-0"></i></button>
                        </div>
                    </div>

                </div>
            </div>
                @endif

            <div class="row justify-content-center mt-5 px-4 mx-1">
                <div class="col-10 post-comment-indicator">
                    <div class="row justify-content-between align-items-center comment-indicator-row mb-3">
                        <div class="col-auto m-0 p-0">
                            <h3 class="mt-0 py-0 mb-1">Comments</h3>
                        </div>
                        <div class="col-auto p-0 m-0">
                            <div class="dropdown p-0 m-0">
                                <button class="btn btn-secondary dropdown-toggle comment-sort-by-button p-0 m-0" type="button" id="comments-sort-by" data-bs-toggle="dropdown" aria-expanded="false">Sort by</button>
                                <ul class="dropdown-menu comments-sort-by" aria-labelledby="comments-sort-by">
                                    <li><a class="dropdown-item">Most popular</a></li>
                                    <li><a class="dropdown-item">Newest</a></li>
                                    <li><a class="dropdown-item">Oldest</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            @if($user=="authenticated_user") {{-- User is not the owner of the post --}}
            <div class="row justify-content-center px-4 mx-1">
                <div class="col-10 mx-0 px-0" style="border-radius:5px;">
                    <div class="row m-0 p-0">
                        <div class="d-flex mx-0 px-0">
                            <!--<label class="post-page-add-comment-label" for="add-comment">Add comment...</label>-->
                            <textarea class="container form-control post-page-add-comment w-100 add-comment" id="add-comment" rows="2" placeholder="Join the discussion"></textarea>
                        </div>
                    </div>
                    <div class="row px-0 mx-0 justify-content-end">
                        <div class="col-auto px-0">
                            <button id="add_comment_button" class="post-page-comment-button btn mt-1 mb-2">Comment</button>
                        </div>
                    </div>
                </div>
            </div>
            @endif
            <span id="comment-section">
            @foreach($metadata['comments'] as $comment)
                        <div class="row justify-content-center px-4 mx-1">
                <div class="col-10 post-page-comment pt-3 pb-2 px-3 mt-2">
                    <div class="row px-2 py-0">
                        <div class="col-auto p-0 m-0">
                            <h3 class="post-page-comment-body m-0">{{$comment['comment']->content}}</h3>
                        </div>
                        <div class="col-auto p-0 m-0 ms-auto">
                            <i class="fas fa-chevron-down ms-auto"></i>
                        </div>
                    </div>
                    <div class="row align-items-end px-2 py-1">
                        <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end">
                            <h3 class="post-page-comment-author-date p-0 m-0">by <a href="./userprofile.php">{{$comment['author']}}</a>, {{$comment['date']}}</h3>
                        </div>
                        <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto">
                            <div class="row">
                                <div class="d-flex">
                                    <h3 class="post-page-comment-interactions pe-3 my-0">{{$comment['likes']}} <i title="Like comment" class="far fa-thumbs-up"></i></h3>
                                    <h3 class="post-page-comment-interactions pe-3 my-0">{{$comment['dislikes']}} <i title="Dislike comment" class="far fa-thumbs-down"></i></h3>
                                    <i title="Report comment" class="fas fa-ban my-0 pe-3 post-page-report-comment"></i>
                                    <h3 class="post-page-comment-interactions my-0">{{$comment['thread_count']}} <i class="far fa-comments"></i></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            @foreach($comment['threads'] as $thread)
                        <div class="row justify-content-center px-4 mx-1">
                <div class="col-10 mx-0 px-0">
                    <div class="row justify-content-end comment-replies mx-0 px-0">
                        <div class="col-11 post-page-comment-reply reply py-2 pt-2 pb-1 mt-1">
                            <div class="row px-2 py-0">
                                <div class="col-auto p-0 m-0">
                                    <h3 class="post-page-comment-reply-body m-0">{{$thread['comment']->content}}</h3>
                                </div>
                            </div>
                            <div class="row align-items-end px-2 py-0">
                                <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end">
                                    <h3 class="post-page-comment-reply-author-date p-0 m-0">by <a href="./userprofile.php">{{$thread['author']}}</a>, {{$thread['date']}}</h3>
                                </div>
                                <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto">
                                    <div class="row">
                                        <div class="d-flex">
                                            <h3 class="post-page-comment-interactions pe-3 my-0">{{$thread['likes']}} <i title="Like comment" class="far fa-thumbs-up"></i></h3>
                                            <h3 class="post-page-comment-interactions pe-3 my-0">{{$thread['dislikes']}} <i title="Dislike comment" class="far fa-thumbs-down"></i></h3>
                                            <i title="Report comment" class="fas fa-ban my-0 post-page-report-comment"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            @endforeach
            @if($user!="visitor")
            <div class="row justify-content-center px-4 mx-1">
                <div class="col-10 mx-0 px-0">
                    <div class="row justify-content-end comment-replies mx-0 px-0">
                        <div class="col-11 post-page-comment-reply-editor px-0 mx-0 mt-1">
                            <div class="row px-0 mx-0">
                                <div class="d-flex mx-0 px-0">
                                        <textarea class="container form-control post-page-add-comment-reply w-100 add-thread" id="add-comment" rows="1"
                                                  placeholder="Answer in thread"></textarea>
                                </div>
                            </div>
                            <div class="row px-0 mx-0 justify-content-end">
                                <div class="col-auto px-0">
                                    <button class="post-page-comment-button btn m-0 mt-1">Comment</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            @endif
            @endforeach
            </span>

            

            <div class="row justify-content-center px-4 mx-1">
                <div class="row justify-content-center mt-4 mb-2 mx-0 p-0">
                    <div class="col-10">
                        <div class="row">
                            <button class="post-page-load-comments-button btn m-0 mt-1">Load 2 more  comments</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
@endsection
