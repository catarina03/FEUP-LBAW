@extends('layouts.app')

@section('content')
    <script  src="{{ asset('js/toaster.js') }}" defer></script>
    <script src="{{ asset('js/edit_roles.js')}}" defer></script>
    <div class="manageRoles row g-0 pt-lg-5 pt-3 d-flex justify-content-center" style="margin-top: 4em; margin-bottom: 7em;">
        <h1 class="text-center p-2 pb-3" style="font-weight:bold;color:#307371;">Manage Roles</h1>
        <div class="manageRoles-center col-12 col-lg-8">
            <div class="card d-flex justify-content-center p-4" style="border:none;">
                <div class="input-group rounded m-0 p-0">
                    <input type="text" class="form-control" id="search"
                           placeholder="Search a person by username to edit their role" aria-label="Search"
                           aria-describedby="search-addon"/>
                    <button class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <div class="spinner d-none justify-content-center pt-3">
                    <div class="spinner-border" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                @include('pages.change_role_modal')
                <div class=" roles-list">
                    @include('partials.roles_list', ['roles' => $roles])
                </div>
            </div>
        </div>

    </div>
    @include('partials.list_toasters')
    @include('partials.error')

@endsection
