<div  class=" position-fixed bottom-0 end-0 p-3" style="z-index: 5">
    <div id="liveToast" class=" toast-generic-php toast hide" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">Action completed!</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close" style="background-color:white;"></button>
        </div>
        <div class="toast-body">
            {{$text}}
        </div>
    </div>
</div>
