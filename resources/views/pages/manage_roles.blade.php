@extends('layouts.app')

@section('content')
    <script src="{{ asset('js/edit_roles.js')}}" defer></script>
    <div class="container manage_roles-card">
        <section class="row d-flex justify-content-center" style="background-color:#8ab5b1;border-radius:2%;">
            <div class="col-lg-9 col-11 justify-content-center mb-3">
                <h1 class="text-center manage_roles-title mt-1 m-3">Manage Roles</h1>
                <div class="card pt-2 row" style="background-color:#8ab5b1; border:none;">
                    <div class="input-group rounded m-0 p-0">
                        <input type="search" class="form-control"
                               placeholder="Search a person by username to edit their role" aria-label="Search"
                               aria-describedby="search-addon"/>
                        <button class="input-group-text border-0" id="search-addon" style="background-color:#fcf3ee;">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                    <ul class="container mt-4 overflow-auto"
                        style="font-size:16px;background-color:#fcf3ee;max-height:30rem;">
                        @foreach($roles as $role)
                            <li class="row pt-1 role-row" data-id="{{$role->id}}">
                                <ul class="col-5 ps-5 d-flex align-items-center roles-username">
                                    <a href="{{ url('user/'.$role->id) }}"> {{$role->username}}</a>
                                </ul>
                                <ul class="col-4 d-flex align-items-center justify-content-center roles-role"
                                    style="border-left: 2px solid #8ab5b1;">
                                    {{$role->authenticated_user_type}}
                                </ul>
                                <ul class="col-3 text-center" style="border-left: 2px solid #8ab5b1;">
                                    <div class="ps-2 dropdown edit-roles">
                                        <div id="dropdownRoles" data-bs-toggle="dropdown"
                                             aria-expanded="false" data-bs-display="static">
                                            <i class="bi bi-people-fill fs-5"></i>
                                            Edit Role
                                        </div>
                                        <ul class="dropdown-menu dropdown-menu-end""
                                            aria-labelledby="dropdownRoles">
                                            @if($role->authenticated_user_type != "Regular")
                                                <li class="dropdown-item role-item">Regular</li>
                                            @endif
                                            @if($role->authenticated_user_type != "Moderator")
                                                <li class="dropdown-item role-item">Moderator</li>
                                            @endif
                                            @if($role->authenticated_user_type != "System Manager")
                                                <li class="dropdown-item role-item">System Manager</li>
                                            @endif
                                        </ul>
                                    </div>
                                </ul>
                            </li>
                            <hr class="dropdown-divider">
                        @endforeach
                    </ul>
                </div>
            </div>
        </section>
    </div>
@endsection
