<div class="roles-table" style="overflow-x: scroll">
    <table class="table mt-4 roles-list  align-middle">
        <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Username</th>
            <th scope="col">Date of Birth</th>
            <th scope="col">Role</th>
        </tr>
        </thead>
        <tbody>
        @if(count($roles) > 0)
            @foreach($roles as $role)
                <tr class="role-user" data-id="{{$role->id}}">
                    <td class="col-md-3 ps-3">{{$role->name}}</td>
                    <td class="col-md-3 roles-username ps-3"><a
                            href="{{ url('user/'.$role->id) }}">{{$role->username}}</a></td>
                    <td class="col-md-3 ps-3">{{$role->birthdate}}</td>
                    <td class="col-md-3">
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

