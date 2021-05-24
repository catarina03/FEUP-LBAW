@extends('layouts.app')

@section('content')
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/comments_aux.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/delete_confirm.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/save_post.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/report_content.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/add_thread.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/add_comment.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/delete_comment.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/edit_comment.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/sort_comments.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/show_threads.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/load_more.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/post_comments/follow_tag.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/votePost.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/voteComment.js') }}" defer></script>
    <div class="container post">
        <p hidden id="post_ID">{{$post->id}}</p>
        <p hidden id="user_ID">{{$user_id}}</p>
        <div class="row" style="margin-top: 7em; margin-bottom: 7em;">
            <div class="card post-page-post-card justify-content-center pb-5" style="border-radius:5px;">

                @auth
                    @if($isOwner)
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
                            <span class="save_post_id" hidden>{{$post->id}}</span>
                            <i class="bi {{$metadata['isSaved']?"bi-bookmark-check-fill":"bi-bookmark-plus-fill"}}"
                               title="Save/unsave post" style="font-size:3em; cursor:pointer;"></i>
                        </div>
                    @endif
                @endauth

                <div class="container-fluid d-flex justify-content-center">
                    <div class="mt-2 col-10 justify-content-center d-flex">
                        <div class="row thumbnail-image">
                            <img src="{{URL::asset($metadata['thumbnail'])}}"
                                 class="justify-content-conter" alt="alt src">
                        </div>
                    </div>
                </div>

                <div class="container-fluid d-flex col-10 justify-content-left mt-3">
                    <h1 class="post-page-post-title">{{$post->is_spoiler?"[SPOILER]":""}}{{$post->title}}</h1>
                </div>

                <div class="row justify-content-between">
                    <div class="container-fluid d-flex px-0 col-4 mt-1">
                        <h2 class="post-page-post-author-date">by <a
                                href="{{route('profile',['id'=>$metadata['author']->id])}}">{{$metadata['author']->name}}</a>, {{$metadata['date']}}
                        </h2>
                    </div>

                    <div class="container-fluid d-flex col-2 mt-1">
                        <div class="pe-3">
                            <h3 class="post-page-post-interactions">{{$metadata['views']}} <i class="far fa-eye"></i>
                            </h3>
                        </div>
                        <div class="pe-3">
                            <h3 class="post-page-post-interactions"><span class="up">{{$metadata['likes']}}</span> <i
                                    class="far fa-thumbs-up"></i></h3>
                        </div>
                        <div class="pe-3">
                            <h3 class="post-page-post-interactions"><span class="down">{{$metadata['dislikes']}}</span>
                                <i class="far fa-thumbs-down"></i></h3>
                        </div>
                        <div class="pe-3">
                            <h3 class="post-page-post-interactions"
                                id="post_comment_count">{{$metadata['comment_count']}} <i class="far fa-comments"></i>
                            </h3>
                        </div>
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
                            <div class="col-auto post-page-tag-container px-2 m-1">
                                <a class="post-page-post-tag"
                                   href="{{route("homepage")."/search/filters?peopleFollow=false&tagFollow=false&myPosts=false&" . "type=" . rawurlencode(ucfirst($post->type))}}">{{$post->type}}</a>
                                @auth
                                    <i class="fas fa-square-full" style="color:transparent;"></i>
                                @endauth
                            </div>
                            <div class="col-auto post-page-tag-container px-2 m-1">
                                <a class="post-page-post-tag"
                                   href="{{route("homepage")."/search/filters?peopleFollow=false&tagFollow=false&myPosts=false&" . "category=" . rawurlencode(ucfirst($post->category))}}">{{$post->category}}</a>
                                @auth
                                    <i class="fas fa-square-full" style="color:transparent;"></i>
                                @endauth
                            </div>
                            @foreach($metadata['tags'] as $tag)
                                <div class="col-auto post-page-tag-container px-2 m-1">
                                    <span hidden class="tag_id">{{$tag->id}}</span>
                                    <a class="post-page-post-tag"
                                       href="{{route("homepage")."/search/filters?peopleFollow=false&tagFollow=false&myPosts=false&" . "search=" . rawurlencode($tag->name)}}">{{$tag->name}}</a>
                                    @auth
                                        <i class="{{$tag->isSaved?"fas":"far"}} fa-star follow_tag_icon"
                                           style="cursor:pointer;"
                                           title="{{$tag->isSaved?"Unfollow tag":"Follow Tag"}}"></i>
                                    @endauth
                                </div>
                            @endforeach

                        </div>
                    </div>
                </div>

                @if(!$isOwner) {{-- User is not the owner of the post --}}
                <div class="row justify-content-center mt-3 px-4 mx-1">
                    <div class="col-10 mx-0 px-0">
                        <div class="row justify-content-start align-items-center px-0 mx-0">
                            @auth
                                @if($metadata['liked'] == 2)
                                    <div class="col-auto px-0 mx-0">
                                        <button
                                            class="post-page-post-thumbs-up-button  btn ms-0 me-4 px-0 post-up-vote"><i
                                                title="Like post" class="fas fa-thumbs-up"></i></button>
                                    </div>
                                @else
                                    <div class="col-auto px-0 mx-0">
                                        <button class="post-page-post-thumbs-up-button btn ms-0 me-4 px-0 post-up-vote">
                                            <i title="Dislike post" class="far fa-thumbs-up"></i></button>
                                    </div>
                                @endif
                                @if($metadata['liked'] == 1)
                                    <div class="col-auto px-0 mx-0">
                                        <button
                                            class="post-page-post-thumbs-down-button btn ms-0 me-4 px-0 post-down-vote">
                                            <i title="Dislike post" class="fas fa-thumbs-down m-0"></i></button>
                                    </div>
                                @else
                                    <div class="col-auto px-0 mx-0">
                                        <button
                                            class="post-page-post-thumbs-down-button btn ms-0 me-4 px-0 post-down-vote">
                                            <i title="Dislike post" class="far fa-thumbs-down m-0"></i></button>
                                    </div>
                                @endif
                                @if(!$post->reported)
                                    <div class="col-auto px-0 mx-0 ms-auto">
                                        <span hidden class="content_id post_content">{{$post->id}}</span>
                                        <button
                                            class="post-page-post-report-button btn ms-0 me-0 py-0 px-0 report_action report_post_button"
                                            data-bs-toggle="modal" data-bs-target="#report"><i title="Report post"
                                                                                               class="fas fa-ban m-0"></i>
                                        </button>
                                    </div>
                                @endif
                            @endauth
                            @guest
                                <p>TO DO: add links to login/register</p>
                            @endguest
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
                @auth
                    @if(!$isOwner) {{-- User is not the owner of the post --}}
                    <div class="row justify-content-center px-4 mx-1">
                        <div class="col-10 mx-0 px-0" style="border-radius:5px;">
                            <div class="row m-0 p-0">
                                <div class="d-flex mx-0 px-0">
                                    <!--<label class="post-page-add-comment-label" for="add-comment">Add comment...</label>-->
                                    <textarea class="container form-control post-page-add-comment w-100 add-comment"
                                              id="add-comment" rows="2" placeholder="Join the discussion"></textarea>
                                </div>
                            </div>
                            <div class="row px-0 mx-0 justify-content-end">
                                <div class="col-auto px-0">
                                    <button id="add_comment_button" class="post-page-comment-button btn mt-1 mb-2">
                                        Comment
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    @endif
                @endauth
                <span id="comment-section">
            @if(count($metadata['comments']) > 0)
                        @include("partials.comments",["comments"=>$metadata['comments'],"user_id"=>$user_id])
                    @else
                        <div class="container-fluid d-flex col-10 justify-content-center mt-3">
                    <p><b id="empty-comments">There are no comments in this post. Be the first to leave your thoughts!</b></p>
                </div>
                    @endif
            </span>


                @if($metadata['comment_count']>5)
                    <div class="row justify-content-center px-4 mx-1">
                        <div class="row justify-content-center mt-4 mb-2 mx-0 p-0">
                            <div class="col-2">
                                <div class="row">
                                    <button id="load_more" class="post-page-load-comments-button btn m-0 mt-1">Load
                                        more
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                @endif

            </div>
        </div>
    </div>
@include('pages.confirm')
@include('partials.report_modal')
@endsection

