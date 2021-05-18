@extends('layouts.app')

@section('content')
    <script type="text/javascript" src="{{ URL::asset('js/save_post.js') }}" defer></script>
    <div class="advanced_search row g-0" style="margin-top: 6em; margin-bottom: 7em;">
        <div class="advanced_search-icon col-12 col-lg-2 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
            <i class="bi bi-search d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
            <h2 style="font-weight:bold;color:#307371;">Advanced Search</h2>
        </div>
        <div class="advanced_search-center  col-12 col-lg-7 ">
            <div class="postsCards row mt-3">
                <p class="number-res pt-4 ps-4 fs-4">{{$number_res}} results found!</p>
                @if($number_res > 0)
                    @each('partials.card', $posts, 'post')
                @endif
            </div>
            @if($number_res > 15)
                @include('partials.pagination')
            @endif
        </div>
        @include('partials.filterBoxWCategory')
    </div>
@endsection
