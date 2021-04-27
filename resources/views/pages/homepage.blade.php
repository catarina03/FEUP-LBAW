@extends('layouts.altart-app')

@section('content')
<div class="homepage row g-0" style="margin-top: 5em; margin-bottom:7em;">
    <div class="homepage-view col-lg-2 col-12 pt-lg-5 pt-2 ps-lg-5">
        <nav class="nav w-100 d-lg-block d-flex justify-content-center">
            <a class="nav-link active fs-5" href="#"><img src="images/bar-chart.svg" height="25">Top</a>
            <a class="nav-link fs-5" href="#"><img src="images/flame.svg" height="25">Hot</a>
            <a class="nav-link fs-5" href="#"><img src="images/calendar.svg" height="25">New</a>
        </nav>
    </div>
    <div class="homepage-center col-12 col-lg-7">
        @include('partials.slider_card')
        <div class="postsCards row">
            @include('partials.card')
            @include('partials.card')
            @include('partials.card')
            @include('partials.card')
            @include('partials.pagination')
        </div>
    </div>
    @include('partials.filterbox')
</div>
@endsection
