@extends('layouts.app')

@section('content')
    <div class="container manage_roles-card">
        <section class="row d-flex justify-content-center" style="background-color:#8ab5b1;border-radius:2%;">
            <div class="col-lg-9 col-11 justify-content-center mb-3"  style="height:40rem;">
                <h1 class="text-center manage_roles-title mt-1 m-3">Manage Roles</h1>
                <div class="roles-card pt-2 row" style="background-color:#8ab5b1; border:none;">
                    <div class="input-group rounded m-0 p-0">
                        <input type="search" class="form-control" id="search"
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
                    <ul class="container mt-4 overflow-auto roles-list"
                        style="font-size:16px;background-color:#fcf3ee; max-height:30rem;">
                        @include('partials.roles_list', ['roles' => $roles])
                    </ul>
                </div>
            </div>
        </section>
    </div>
@endsection
