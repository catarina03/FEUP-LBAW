@extends('layouts.app')

@section('content')
<script type="text/javascript" src="{{ URL::asset('js/filterBox.js') }}" defer></script>
<div class="advanced_search row g-0" style="margin-top: 6em; margin-bottom: 7em;">
    <div class="advanced_search-icon col-12 col-lg-2 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
        <i class="bi bi-search d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
        <h2 style="font-weight:bold;color:#307371;">Advanced Search</h2>
    </div>
    <div class="advanced_search-center  col-12 col-lg-7 order-2 order-lg-1">
        <p class="pt-4 ps-4 fs-4">{{count($posts)}} results found!</p>
        @if(count($posts)>0)
            <div class="postsCards row mt-3">
                @each('partials.card', $posts, 'post')
            </div>
                @include('partials.pagination')
        @endif
    </div>

    <div class="custom-filterBox col-lg-3 col-12 text-center order-1 order-lg-2">
        <div class="container" style="position:fixed; margin-left: 20px; ">
            <h4> Search </h4>
            <form class="pt-2" action="" method="get">
                <div class="input-group rounded">
                    <input type="search" id="search" class="form-control" placeholder="Search" aria-label="Search"
                        aria-describedby="search-addon" />
                    <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                        <i class="fas fa-search"></i>
                    </span>
                </div>
                <select class="form-select mt-4" id="category" aria-label="Select a category" style="cursor:pointer;">
                    <option value="" selected>Select a category</option>
                    <option value="Music">Music</option>
                    <option value="Cinema">Cinema</option>
                    <option value="TvShow">TV Show</option>
                    <option value="Theatre">Theatre</option>
                    <option value="Literature">Literature</option>
                </select>
                <select class="form-select mt-4" id="type" aria-label="Select a type" style="cursor:pointer;">
                    <option value="" selected>Select a type</option>
                    <option value="News">News</option>
                    <option value="Article">Article</option>
                    <option value="Review">Review</option>
                    <option value="Suggestion">Suggestion</option>
                </select>
                <input type="date" class="form-control mt-4" id="startDate" aria-label="Start Date"
                    style="cursor:pointer;">
                <a> to </a>
                <input type="date" class="form-control mt-2" id="endDate" aria-label="End Date" style="cursor:pointer;">

                <div class="form-check mt-4">
                    <input class="form-check-input" type="checkbox" value="" id="checkPeople" style="cursor:pointer;">
                    <label class="form-check-label" for="checkPeople">
                        Only people I follow
                    </label>
                </div>
                <div class="form-check mt-4">
                    <input class="form-check-input" type="checkbox" value="" id="checkTags" style="cursor:pointer;">
                    <label class="form-check-label" for="checkTags">
                        Only tags I follow
                    </label>
                </div>

                <input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">
            </form>
        </div>
    </div>
</div>
@endsection
