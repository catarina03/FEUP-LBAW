<script src="{{ asset('js/edit_roles.js')}}" defer></script>
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
                <ul class="dropdown-menu dropdown-menu-end"
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
