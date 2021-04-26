@extends('layouts.altart-app')

@section('content')
<div class="advanced_search row g-0" style="margin-top: 6em; margin-bottom: 7em;">
    <div class="advanced_search-icon col-12 col-lg-2 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
        <i class="bi bi-search d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
        <h2 style="font-weight:bold;color:#307371;">Advanced Search</h2>
    </div>
    <div class="advanced_search-center  col-12 col-lg-7 order-2 order-lg-1">
        <p class="pt-4 ps-4 fs-4">4 results found!</p>
        <div class="postsCards row mt-3">
                @include('partials.card')
                @include('partials.card')
                @include('partials.card')
                @include('partials.card')
        </div>
        <div class="d-flex justify-content-center">
            <div class="pagination">
                <a href="#">&laquo;</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">&raquo;</a>
            </div>
        </div>
    </div>
    <div class="custom-filterBox col-lg-3 col-12 text-center order-1 order-lg-2">
        <div class="container">
            <h4> Search </h4>
            <form class="pt-2" action="advanced_search.php" method="post">
                <div class="input-group rounded">
                    <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                        aria-describedby="search-addon" />
                    <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                        <i class="fas fa-search"></i>
                    </span>
                </div>
                <select class="form-select mt-4" aria-label="Select a category" style="cursor:pointer;">
                    <option value="" selected>Select a category</option>
                    <option value="1">Music</option>
                    <option value="2">Cinema</option>
                    <option value="3">TV Show</option>
                    <option value="4">Theatre</option>
                    <option value="5">Literature</option>
                </select>
                <select class="form-select mt-4" aria-label="Select a type" style="cursor:pointer;">
                    <option value="" selected>Select a type</option>
                    <option value="1">News</option>
                    <option value="2">Article</option>
                    <option value="3">Review</option>
                    <option value="4">Suggestion</option>
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