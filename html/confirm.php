<?php 

    function confirm_pop_up(){
?>

<div class="" tabindex="-1"> <!-- add model here-->
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color:#307371; color:white;">
                <h5 class="modal-title ">Confirm</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body ms-3">
                <p>Are you sure you want to do this?</p>
            </div>
            <div class="row justify-content-end d-flex me-3 mb-3">
                <button type="button" class="col-2 btn btn-secondary me-4" data-bs-dismiss="modal">No</button>
                <button type="button" class="col-2 btn custom-button">Yes</button>
            </div>
        </div>
    </div>
</div>

<?php
    }
?>