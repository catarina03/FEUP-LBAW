<div class="report-actions m-0 p-0">
    @if(!$assigned)
        <button class="assign-button btn btn-outline-dark"> Assign to me</button>
    @else
        <button class="action-button btn btn-outline-dark" data-bs-toggle="modal"
                data-bs-target="#report_action"> Action
        </button>
    @endif
</div>
