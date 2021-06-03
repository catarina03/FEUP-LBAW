@extends('layouts.app')

@section('content')
    <script src="{{ asset('js/reports.js')}}" defer></script>
    <div class="moderator row g-0" style="margin-top: 6em; margin-bottom: 7em;">
        <div class="moderator-icon col-12 col-lg-2 pt-lg-5 pt-2 pb-3 text-center justify-content-center">
            <i class="bi bi-people-fill d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
            <h2 style="font-weight:bold;color:#307371;">Moderator Dashboard</h2>
        </div>
        <div class="moderator-center col-12 col-lg-7">
            @include('partials.moderator_card', ['reports' => $reports])
        </div>
        <div class="custom-filterBox col-md-3 text-center d-lg-block d-none ">
            <div class="container">
                <h4> Filter </h4>
                <form class="pt-2" action="#" method="post">
                    <div class="input-group rounded">
                        <input type="search" class="form-control" placeholder="Search" aria-label="Search"
                               aria-describedby="search-addon"/>
                        <span class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                        <i class="fas fa-search"></i>
                    </span>
                    </div>
                    <select class="form-select mt-4" aria-label="Select a type" style="cursor:pointer;">
                        <option value="" selected>Select a type</option>
                        <option value="1">News</option>
                        <option value="2">Article</option>
                        <option value="3">Review</option>
                        <option value="4">Suggestion</option>
                    </select>
                    <select class="form-select mt-4" aria-label="Select a category" style="cursor:pointer;">
                        <option value="" selected>Select a category</option>
                        <option value="1">Music</option>
                        <option value="2">Cinema</option>
                        <option value="3">TV Show</option>
                        <option value="4">Theatre</option>
                        <option value="5">Literature</option>
                    </select>
                    <select class="form-select mt-4" aria-label="Select date order" style="cursor:pointer;">
                        <option value="" selected>Select date ordering</option>
                        <option value="1">Date: Newer</option>
                        <option value="2">Date: Older</option>
                        <option value="3">Date: Unordered</option>
                    </select>
                    <div class="form-check mt-4">
                        <input class="form-check-input" type="checkbox" value="" id="checkAssigned"
                               style="cursor:pointer;">
                        <label class="form-check-label" for="checkAssigned">
                            Assign to me
                        </label>
                    </div>
                    <div class="form-check mt-4">
                        <input class="form-check-input" type="checkbox" value="" id="checkNotAssigned"
                               style="cursor:pointer;">
                        <label class="form-check-label" for="checkNotAssigned">
                            Unassigned
                        </label>
                    </div>

                    <input type="submit" class="filterButton w-100 mt-4 p-1" value="Filter">
                </form>
            </div>
        </div>
    </div>

{{--    @include('pages.report_action')--}}
@endsection

