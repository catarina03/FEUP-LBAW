@extends('layouts.app')

@section('content')
    <script src="{{ asset('js/reports.js')}}" defer></script>
    <div class="manageRoles row g-0 pt-lg-5 pt-3" style="margin-top: 4em; margin-bottom: 7em;">
        <div class="manageRoles-icon col-12 col-lg-3 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
            <i class="bi bi-list-task d-lg-block d-none" style="font-size:6em;color:#0c1d1c;"></i>
            <h2 style="font-weight:bold;color:#307371;">Manage Reports</h2>
        </div>
        <div class="manageRoles-center col-12 col-lg-7">
            <div class="card d-flex justify-content-center p-4" style="background-color:#8ab5b1;">
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

