<div class="modal fade edit_role_modal" id="edit_role" data-bs-backdrop="static" data-bs-keyboard="true" tabindex="-1"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered justify-content-center d-flex">
        <div class="modal-content justify-content-center">
            <div class="modal-header" style="background-color:#307371; color:white;">
                <h5 class="modal-title justify-content-center">Edit Role</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="form-group">
                <label for="selectNewRole" class="p-4">Which role do you want to change to?</label>
                <div class="row p-0 m-0 justify-content-center roles-select">
                    <select class="form-select edit_role_select" id="selectNewRole" aria-label="Select a role"
                            style="width: 80%">
                    </select>
                </div>
                <div class="motive-error d-none p-0 m-0 justify-content-center text-center" style="color: darkred">
                    Role is required!
                </div>
            </div>
            <div class="row justify-content-center d-flex pt-5 pb-3">
                <button class="col-4 btn btn-secondary me-3" data-bs-dismiss="modal">Cancel</button>
                <button class="col-4 btn custom-button ms-3 edit_button">Edit Role</button>
            </div>

        </div>
    </div>
</div>

