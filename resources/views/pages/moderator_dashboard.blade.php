@extends('layouts.app')
{{--style="background-color:#8ab5b1;"--}}
@section('content')
    <script src="{{ asset('js/reports.js')}}" defer></script>
    <div class="manageReports row g-0 pt-lg-5 pt-3 d-flex justify-content-center" style="margin-top: 4em; margin-bottom: 7em;">
        <h1 class="text-center p-2 pb-3" style="font-weight:bold;color:#307371;">Manage Reports</h1>
        <div class="manageReports-center col-12 col-lg-8">
            <div class="card d-flex justify-content-center p-4" style="border:none;">
                <div class="input-group rounded m-0 p-0">
                    <input type="text" class="form-control" id="search"
                           placeholder="Search a person by username to edit their role" aria-label="Search"
                           aria-describedby="search-addon"/>
                    <button class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <div class="roles-list">
                    @include('partials.moderator_card', ['reports' => $reports])
                </div>
            </div>
        </div>

    </div>

@endsection

