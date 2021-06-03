@extends('layouts.app')

@section('content')
<div class="category row g-0" style="margin-top: 6em; margin-bottom: 7em;">
    <div class="category-icon col-12 col-lg-2 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
        <img src="/images/{{$category}}.png" class="pb-2" style="width: 40%;">
        <h2 style="font-weight:bold;color:#307371;">{{$category}}</h2>
    </div>
    <div class="category-center col-12 col-lg-7">

        <div class="postsCards row">
            @each('partials.card', $posts, 'post')
        </div>
        @include('partials.pagination')
    </div>
    @include('partials.filterbox')
</div>
@endsection
