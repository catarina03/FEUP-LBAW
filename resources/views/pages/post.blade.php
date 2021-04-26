@extends('layouts.altart-app')

@section('content')
<div class="container post">
    <div class="row" style="margin-top: 7em; margin-bottom: 7em;">
        <div class="card post-page-post-card justify-content-center pb-5" style="border-radius:5px;">

            @if($user != 'visitor')
                @if(''){{-- Se for o próprio owner a ver --}}
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
                        <img src="https://d15v4l58k2n80w.cloudfront.net/file/1396975600/25413991727/width=1600/height=900/format=-1/fit=crop/crop=394x0+6541x3684/rev=3/t=443967/e=never/k=756accaa/Untitled_Panorama6.jpg"
                             class="justify-content-conter" alt="Royal Albert Hall">
                    </div>
                </div>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-3">
                <h1 class="post-page-post-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New Video</h1>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-1">
                <h2 class="post-page-post-author-date">by <a href="./myprofile.php">Ana Sousa</a>, FEBRUARY 23, 2021</h2>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-1">
                <div class="pe-3">
                    <h3 class="post-page-post-interactions">4 <i class="far fa-eye"></i></h3>
                </div>
                <div class="pe-3">
                    <h3 class="post-page-post-interactions">1 <i class="far fa-thumbs-up"></i></h3>
                </div>
                <div class="pe-3">
                    <h3 class="post-page-post-interactions">0 <i class="far fa-thumbs-down"></i></h3>
                </div>
                <div class="pe-3">
                    <h3 class="post-page-post-interactions">2 <i class="far fa-comments"></i></h3>
                </div>
            </div>

            <div class="container-fluid d-flex col-10 justify-content-left mt-2">
                <p class="post-page-post-text">Mick Jagger narrates a new film on London’s Royal Alberts Hall in
                    celebration
                    of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes scenes
                    of the empty venue during the pandemic.
                    <br>“I would like to take this opportunity to wish the Royal Albert Hall a very happy 150th
                    birthday and look forward to the future, seeing and listening to many fantastic artists and
                    musicians performing onstage at this iconic venue,” Jagger says.
                    <br>“I have desperately missed live performance — there is something electric and fundamentally
                    human about the shared experience of being in a room surrounded by other people, part of an
                    audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty,
                    but what makes it truly special is the connection it fosters through those shared experiences.
                    That is what this film is about: Not only a celebration of performances from the Hall’s glorious
                    past, but also the sense of anticipation of some of the things to look forward to when we can be
                    together again.”
                    <br>...<br>... <br>“I have desperately missed live performance — there is something electric and
                    fundamentally human about the shared experience of being in a room surrounded by other people,
                    part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when
                    it’s empty, but what makes it truly special is the connection it fosters through those shared
                    experiences. That is what this film is about: Not only a celebration of performances from the
                    Hall’s glorious past, but also the sense of anticipation of some of the things to look forward
                    to when we can be together again.”
                </p>
            </div>

            <div class="row justify-content-center mt-3 mb-3 px-4 mx-1">
                <div class="col-10">
                    <div class="row justify-content-start align-items-center">
                        <h2 class="col-auto post-page-post-tags-indicator m-0 p-0">Tags: </h2>
                        <div class="col-auto post-page-tag-container px-2 m-1">
                            <a class="post-page-post-tag" href="advanced_search.php">Music</a>
                        </div>
                        <div class="col-auto post-page-tag-container px-2 m-1">
                            <a class="post-page-post-tag" href="advanced_search.php">News</a>
                        </div>
                        <div class="col-auto post-page-tag-container px-2 m-1">
                            <a class="post-page-post-tag" href="advanced_search.php">Band</a>
                        </div>
                        <div class="col-auto post-page-tag-container px-2 m-1">
                            <a class="post-page-post-tag" href="advanced_search.php">Performance</a>
                        </div>
                    </div>
                </div>
            </div>

                @if(true) {{-- User is not the owner of the post --}}
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

            @if(true) {{-- User is not the owner of the post --}}
            <div class="row justify-content-center px-4 mx-1">
                <div class="col-10 mx-0 px-0" style="border-radius:5px;">
                    <div class="row m-0 p-0">
                        <div class="d-flex mx-0 px-0">
                            <!--<label class="post-page-add-comment-label" for="add-comment">Add comment...</label>-->
                            <textarea class="container form-control post-page-add-comment w-100" id="add-comment" rows="2" placeholder="Join the discussion"></textarea>
                        </div>
                    </div>
                    <div class="row px-0 mx-0 justify-content-end">
                        <div class="col-auto px-0">
                            <button class="post-page-comment-button btn mt-1 mb-2">Comment</button>
                        </div>
                    </div>
                </div>
            </div>
            @endif

            @include('partials.comment')
            @include('partials.comment')
            @include('partials.comment')
            @include('partials.thread_comment')

            <div class="row justify-content-center px-4 mx-1">
                <div class="col-10 mx-0 px-0">
                    <div class="row justify-content-end comment-replies mx-0 px-0">
                        <div class="col-11 post-page-comment-reply-editor px-0 mx-0 mt-1">
                            <div class="row px-0 mx-0">
                                <div class="d-flex mx-0 px-0">
                                        <textarea class="container form-control post-page-add-comment-reply w-100" id="add-comment" rows="1"
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
