<div class="roles-table mt-4" style="overflow-x: auto; border: solid 1px black;">
    <table class="table roles-list align-middle table-hover mb-0 pb-0" style="background-color:#fcf3ee;">
        <thead>
        <tr>
            <th class="p-3" scope="col"></th>
            <th class="p-3" scope="col">Name</th>
            <th class="p-3" scope="col">Username</th>
            <th class="p-3" scope="col">Role</th>
        </tr>
        </thead>
        <tbody>
        @if(count($roles) > 0)
            @foreach($roles as $role)
                <tr class="role-user" data-id="{{$role->id}}" data-role="{{ $role->authenticated_user_type}}"
                    style="cursor:pointer;">
                    <td class="role-item col-md-3 p-3 ps-4"><img src="{{URL::asset($role->profile_photo)}}"
                                                                 class="img-thumbnail" alt="..."></td>
                    <td class="role-item col-md-3 p-3">{{$role->name}}</td>
                    <td class="role-item col-md-3 roles-username p-3">{{$role->username}}</td>
                    <td class="col-md-3 p-3 roles">
                        @include('partials.roles_types', ['type' => $role->authenticated_user_type])
                    </td>
                </tr>
            @endforeach
        @else
            <tr>
                <td>No results found!</td>
            </tr>
        @endif
        </tbody>
    </table>
</div>
<nav class="table-pagination">
    <div class="pagination">
        {!! $roles->links() !!}
    </div>
</nav>

