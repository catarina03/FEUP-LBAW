@if(!($comment->comment_id==null?false:true))
    <div class="comment-container">
                <div hidden class="owner_id">{{$comment->user_id}}</div>
                <div class="row justify-content-center px-4 mx-1">
                    <div class="col-10 post-page-comment pt-3 pb-2 px-3 mt-2 comment_box">
                    <div class="row px-2 py-0">
                        <div class="col-11 p-0 m-0 d-flex comment_content_container align-items-end">
                            <h3 class="post-page-comment-body m-0 comment_content">{!! nl2br(e($comment->content)) !!}</h3>
                        </div>
                        <div class="col-auto p-0 m-0 ms-auto">
                            <div class="comment_id COMMENTID" hidden>{{$comment->id}}</div>

                            @if($comment->isOwner)
                                <div class="dropdown" data-toggle="tooltip" data-placement="bottom" title="Actions">
                                <b class="btn fa-cog-icon" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-cog ms-auto"></i>
                                </b>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <b class="dropdown-item edit_comment_button">Edit Comment</b>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <b class="dropdown-item delete_comment_button">Delete Comment</b>
                                </ul>
                            </div>
                            @endif

                        </div>
                    </div>
                    <div class="row align-items-end px-2 py-1">
                        <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end">
                            <h3 class="post-page-comment-author-date p-0 m-0">by <a
                                    href="{{route('profile',['id'=>$comment->user_id])}}">{{$comment->author}}</a>, {{$comment->comment_date}}</h3>
                        </div>
                        <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto">
                            <div class="row">
                                <div class="d-flex comment_interactions align-items-end">
                                     @if($comment->liked == 2)
                                        <h3 class="post-page-comment-interactions p-0 m-0 d-flex align-items-end" data-toggle="tooltip" data-placement="bottom" title="Liked comment">
                                            <span class="up  ">{{$comment->likes}}</span>
                                             <button class="post-page-comment-thumbs-up-button btn d-flex align-items-end" style="padding-bottom:0;">
                                                <i class="fas fa-thumbs-up "></i></button>
                                        </h3>
                                    @else
                                        <h3 class="post-page-comment-interactions p-0 m-0 d-flex align-items-end" data-toggle="tooltip" data-placement="bottom" title="Like comment">
                                            <span class="up "
                                            >{{$comment->likes}}</span>
                                             <button class="post-page-comment-thumbs-up-button btn d-flex align-items-end" style="padding-bottom:0;">
                                                <i class="far fa-thumbs-up "></i></button>
                                        </h3>
                                    @endif
                                    @if($comment->liked == 1)
                                        <h3 class="post-page-comment-interactions p-0 m-0 d-flex align-items-end" data-toggle="tooltip" data-placement="bottom" title="Disliked comment"><span
                                                class="down"
                                            >{{$comment->dislikes}}</span>
                                            <button class="post-page-comment-thumbs-down-button btn m-0 mr-2 d-flex align-items-end" style="padding-bottom:0;">
                                                <i class="fas fa-thumbs-down"></i>
                                            </button>
                                        </h3>
                                    @else
                                        <h3 class="post-page-comment-interactions p-0 m-0 d-flex align-items-end" data-toggle="tooltip" data-placement="bottom" title="Dislike comment"><span
                                                class="down"
                                            >{{$comment->dislikes}}</span>
                                            <button class="post-page-comment-thumbs-down-button btn m-0 mr-2 d-flex align-items-end" style="padding-bottom:0;">
                                                <i class="far fa-thumbs-down"></i>
                                            </button>
                                        </h3>
                                    @endif
                                    @auth
                                        @if(!$comment->isOwner)
                                            @if(!$comment->reported)
                                                <div hidden class="content_id comment_content">{{$comment->id}}</div>
                                                <i title="Report comment"
                                                   class="far fa-flag my-0 post-page-report-comment pe-3 report_action"
                                                   data-bs-toggle="modal" data-bs-target="#report"></i>
                                            @else
                                                <div hidden class="content_id comment_content">{{$comment->id}}</div>
                                                <i title="Reported comment"
                                                   class="fas fa-flag my-0 post-page-report-comment pe-3 reported report_action"
                                                    style="color:darkred;"></i>
                                            @endif
                                        @endif
                                    @endauth
                                    <h3 class="post-page-comment-interactions my-0 thread_count" data-toggle="tooltip" data-placement="bottom" title="Thread count">{{$comment->thread_count}} <i
                                            class="far fa-comments"></i></h3>
                                    <h3 class="post-page-comment-interactions my-0 px-3 show-hide-replies" style="cursor:pointer;width:fit-content;" data-toggle="tooltip" data-placement="bottom" title="Show thread"> 
                                        <i class="fas fa-chevron-right my-0" ></i>{!! "&nbsp;" !!}Show thread
                                    </h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="comment_thread_section d-none">
                @foreach($comment->threads as $thread)
                    @include('partials.single_comment',["comment"=>$thread])
                @endforeach
            </div>
            @auth
            <div class="row justify-content-center px-4 mx-1 thread-reply d-none">
                <div class="col-10 mx-0 px-0">
                    <div class="row justify-content-end comment-replies mx-0 px-0">
                        <div class="col-11 post-page-comment-reply-editor px-0 mx-0 mt-1">
                            <div class="row px-0 mx-0 reply_textarea_container">
                                <div class="col-xl-11 col-lg-12 col-md-12 col-sm-12 d-flex mx-0 px-0 reply_textarea">
                                        <textarea
                                            class="container form-control post-page-add-comment-reply w-100 add-thread"
                                         rows="1"
                                            placeholder="Answer in thread"></textarea>
                                </div>
                                <div class="col-xl-1 col-lg-12 col-md-12 col-sm-12 d-flex mx-0 px-0 justify-content-end">
                                    <div class="thread_comment_id" hidden>{{$comment->id}}</div>
                                    <button
                                        class="post-page-comment-button btn-sm btn-block m-0 mt-0 add_thread_button" data-toggle="tooltip" data-placement="bottom" title="Add comment">Comment</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        @endauth
    </div>
@else
    <div class="thread-container">
                    <div hidden class="owner_id">{{$comment->user_id}}</div>
                    <div class="row justify-content-center px-4 mx-1 thread-section">
                        <div class="col-10 mx-0 px-0 comment_box">
                            <div class="row justify-content-end comment-replies mx-0 px-0">
                                <div class="col-11 post-page-comment-reply reply py-2 pt-2 pb-1 mt-1">
                                    <div class="row px-2 py-0">
                                        <div class="col-11 p-0 m-0 d-flex comment_content_container align-items-end">
                                            <h3 class="post-page-comment-reply-body m-0 comment_content">{{$comment->content}}</h3>
                                        </div>

                                        <div class="col-auto p-0 m-0 ms-auto">
                                            <div class="comment_id THREADID" hidden>{{$comment->id}}</div>
                                            <div class="parent_id" hidden>{{$comment->comment_id}}</div>
                                            @if($comment->isOwner)

                                                <div class="dropdown" data-toggle="tooltip" data-placement="bottom" title="Actions">
                                                <b class="btn fa-cog-icon" style="font-size:30%;"
                                                   data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="fas fa-cog ms-auto" style="font-size:3em;"></i>
                                                </b>
                                                <ul class="dropdown-menu dropdown-menu-end">
                                                    <b class="dropdown-item edit_comment_button">Edit Comment</b>
                                                    <li>
                                                        <hr class="dropdown-divider">
                                                    </li>
                                                    <b class="dropdown-item delete_comment_button">Delete Comment</b>
                                                </ul>
                                            </div>
                                            @endif
                                        </div>
                                    </div>
                                    <div class="row align-items-end px-2 py-0">
                                        <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end">
                                            <h3 class="post-page-comment-reply-author-date p-0 m-0">by <a
                                                    href="{{route('profile',['id'=>$comment->user_id])}}">{{$comment->author}}</a>, {{$comment->comment_date}}</h3>
                                        </div>

                                        <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto">
                                            <div class="row">
                                                <div class="d-flex comment_interactions">

                                                    @if($comment->liked == 2)
                                                        <h3 class="post-page-comment-interactions p-0 m-0 d-flex align-items-end" style="padding-bottom:0;">
                                                            <span class="up " style="padding-right:5%;">{{$comment->likes}}</span>
                                                            <button class="post-page-comment-thumbs-up-button btn d-flex align-items-end" style="padding-bottom:0;">
                                                            <i class="fas fa-thumbs-up"></i></button>
                                                        </h3>
                                                    @else
                                                        <h3 class="post-page-comment-interactions p-0  m-0 d-flex align-items-end"  style="padding-bottom:0;">
                                                            <span class="up" style="margin-right:-0.7rem; margin-top:1.5rem;padding-right:5%;">{{$comment->likes}}</span>
                                                            <button class="post-page-comment-thumbs-up-button btn d-flex align-items-end" style="padding-bottom:0;">
                                                                <i class="far fa-thumbs-up"></i></button>
                                                        </h3>
                                                    @endif
                                                    @if($comment->liked == 1)
                                                        <h3 class="post-page-comment-interactions p-0 m-0 d-flex align-items-end"  style="padding-bottom:0;">
                                                            <span class="down" style="padding-right:5%;">{{$comment->dislikes}}</span>
                                                            <button class="post-page-comment-thumbs-down-button btn m-0 mr-2 d-flex align-items-end"  style="padding-bottom:0;">
                                                                <i class="fas fa-thumbs-down"></i>
                                                            </button>
                                                        </h3>
                                                    @else
                                                        <h3 class="post-page-comment-interactions p-0 m-0 d-flex align-items-end" style="padding-bottom:0;">
                                                            <span class="down"
                                                                style="margin-right:-0.7rem; margin-top:0.8rem;padding-bottom:0;padding-right:5%;">{{$comment->dislikes}}</span>
                                                            <button class="post-page-comment-thumbs-down-button btn m-0 mr-2 d-flex align-items-end" style="padding-bottom:0;">
                                                                <i class="far fa-thumbs-down"></i>
                                                            </button>
                                                        </h3>
                                                    @endif
                                                    @auth
                                                        @if(!$comment->isOwner)
                                                        <div class="d-flex align-items-end">
                                                            <div hidden class="content_id comment_content">{{$comment->id}}</div>
                                                            @if(!$comment->reported)
                                                                <i title="Report comment"
                                                                class="far fa-flag my-0 post-page-report-comment pe-3 report_action"
                                                                data-bs-toggle="modal" data-bs-target="#report"></i>
                                                            @else

                                                                <i title="Reported comment"
                                                                class="fas fa-flag my-0 post-page-report-comment pe-3 reported report_action"
                                                                    style="color:darkred;"></i>
                                                            @endif
                                                        </div>
                                                        @endif
                                                    @endauth
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
             </div>
@endif
