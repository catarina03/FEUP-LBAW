@extends('layouts.app')

@section('content')
    <script src="{{ asset('js/reports.js')}}" defer></script>
    <div class="manageReports row g-0 pt-lg-5 pt-3 d-flex justify-content-center"
         style="margin-top: 4em; margin-bottom: 7em;">
        <h1 class="text-center p-2 pb-3" style="font-weight:bold;color:#307371;">Manage Reports</h1>
        <div class="manageReports-center col-12 col-lg-8">
            <div class="card d-flex justify-content-center p-4" style="border:none;">
                <div class="reports-filter">
                    <div class="accordion accordion-flush" id="accordionFlushExample">
                        <div class="accordion-item">
                            <button class="btn btn-outline-dark" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseExample" aria-expanded="false"
                                    aria-controls="collapseExample">
                                <i class="bi bi-funnel p-2"></i> Filter Reports
                            </button>
                            <div class="collapse" id="collapseExample">
                                <div class="card card-body mt-1 p-4" style="background-color:#0c1d1c;">
                                    <div class="row">
                                        <div class="col-lg-4 col-md-6 col-12">
                                            <select class="form-select select-category" aria-label="Select a category">
                                                <option value="" selected>Select a category</option>
                                                <option value="Music">Music</option>
                                                <option value="Cinema">Cinema</option>
                                                <option value="TvShow">TV Show</option>
                                                <option value="Theatre">Theatre</option>
                                                <option value="Literature">Literature</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-12 pt-md-0 pt-3">
                                            <select class="form-select" aria-label="Select a type">
                                                <option selected value="">Select a type</option>
                                                <option value="News">News</option>
                                                <option value="Article">Article</option>
                                                <option value="Review">Review</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-12 pt-lg-0 pt-4">
                                            <select class="form-select" aria-label="Select a type">
                                                <option selected value="">Select a reported content type</option>
                                                <option value="Post">Post</option>
                                                <option value="Comment">Comment</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row pt-3">
                                        <div class="col-lg-4 col-6 pt-lg-0 pt-4">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="defaultCheck1">
                                                <label class="form-check-label" for="defaultCheck1"
                                                       style="color:white;">
                                                    Assign To Me
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-6 pt-lg-0 pt-4">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="defaultCheck1">
                                                <label class="form-check-label" for="defaultCheck1"
                                                       style="color:white;">
                                                    Unassigned
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end pt-4">
                                        <button class="filterButton filter_reports">Filter</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="roles-list">
                    @include('partials.moderator_card', ['reports' => $reports])
                </div>
            </div>
        </div>

    </div>

@endsection

