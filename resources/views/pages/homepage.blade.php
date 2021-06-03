@extends('layouts.app')


@section('content')
<script type="text/javascript" src="{{ URL::asset('js/homepage.js') }}" defer></script>
<div class="homepage row g-0" style="margin-top: 5em; margin-bottom:7em;">
    <div class="homepage-view col-lg-2 col-12 pt-lg-5 pt-2 ps-lg-5">
        <nav class="nav homepage-navbar w-100 d-lg-block d-flex justify-content-center">
            <a class="nav-link active fs-5" id="top" href=''><img src="images/bar-chart.svg" height="25">
                Top
            </a>
            <a class="nav-link fs-5" id="hot" href=''><img src="images/flame.svg" height="25">
                Hot
            </a>
            <a class="nav-link fs-5" id="new" href="/"><img src="images/calendar.svg" height="25">
                New
            </a>
        </nav>
    </div>
    <div class="homepage-center col-12 col-lg-7">
        @include('partials.slider_card', ['posts' => $slideshow])
        <div class="postsCards row">
            @each('partials.card', $posts, 'post')
            @include('partials.pagination')
        </div>
    </div>
    @include('partials.filterbox')
</div>
@endsection
