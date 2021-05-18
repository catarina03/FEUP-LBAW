@extends('layouts.app')


@section('content')
    <script type="text/javascript" src="{{ URL::asset('js/utils.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/homepage.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/save_post.js') }}" defer></script>
    <div class="homepage row g-0" style="margin-top: 5em; margin-bottom:7em;">
        <div class="homepage-view col-lg-2 col-12 pt-lg-5 pt-2 ps-lg-5">
            <nav class="nav homepage-navbar w-100 d-lg-block d-flex justify-content-center">
                <a class="nav-link active fs-5 pe-5" id="top" href=''><img src="images/bar-chart.svg" height="25">
                    Top
                    <div class="spinner-border spinner-border-sm d-none topLoad m-0 p-0" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </a>
                <a class="nav-link fs-5 pe-5" id="hot" href=''><img src="images/flame.svg" height="25">
                    Hot
                    <div class="spinner-border spinner-border-sm d-none  hotLoad m-0 p-0" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </a>
                <a class="nav-link fs-5 pe-5" id="new" href="/"><img src="images/calendar.svg" height="25">
                    New
                    <div class="spinner-border spinner-border-sm d-none newLoad m-0 p-0" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </a>
            </nav>
        </div>
        <div class="homepage-center col-12 col-lg-7">
            @include('partials.slideshowCard', ['posts' => $slideshow])
            <div class="postsCards row">
                @each('partials.card', $posts, 'post')
                @if($n_posts > 15)
                    @include('partials.pagination')
                @else
                    <p>No posts</p>
                @endif
            </div>
        </div>
        @include('partials.filterBox')
    </div>
@endsection
