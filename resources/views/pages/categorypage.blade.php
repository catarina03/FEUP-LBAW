@extends('layouts.app')

@section('content')
    <script type="text/javascript" src="{{ URL::asset('js/toaster.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/utils.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/categoryPage.js') }}" defer></script>
    <script type="text/javascript" src="{{ URL::asset('js/save_post.js') }}" defer></script>
    <div class="category row g-0" style="margin-top: 6em; margin-bottom: 7em;">
        <div class="category-icon col-12 col-lg-2 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
            <img src="/images/{{$category}}.png" class="pb-2" style="width: 40%;" alt="category image">
            <h2 style="font-weight:bold;color:#307371;">{{$category}}</h2>
        </div>
        <div class="category-center col-12 col-lg-7">
            <div class="postsCards row">
                @each('partials.card', $posts, 'post')
            </div>
            @if($n_posts > 15)
                @include('partials.pagination')
            @endif
        </div>
        @include('partials.filterBox')
    </div>
@include('partials.postpage_toaster')
@endsection
