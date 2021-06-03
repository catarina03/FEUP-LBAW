<div class="text-center report-actions" data-id="{{$content_id}}" data-type="{{$type}}">
    @if(!$assigned)
        <p class="assign-button" style="font-weight:bold;" >Assign to me</p>
    @else
        <p class="assign-button report-action-button" style="font-weight:bold;" data-bs-toggle="modal"
           data-bs-target="#report_action">Action</p>
    @endif
</div>
