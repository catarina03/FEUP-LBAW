<div class="dropdown edit-roles" style="cursor: pointer;">
    <button class="edit-roles-button btn dropdown-toggle pb-0 pt-0" type="button"
            id="dropdownRoles" data-bs-toggle="dropdown" aria-expanded="false">
        {{$type}}
    </button>
    <ul class="dropdown-menu"
        aria-labelledby="dropdownRoles">
        @if($type != "Regular")
            <li class="dropdown-item role-item">Regular</li>
        @endif
        @if($type != "Moderator")
            <li class="dropdown-item role-item">Moderator</li>
        @endif
        @if($type != "System Manager")
            <li class="dropdown-item role-item">System Manager</li>
        @endif
    </ul>
</div>
