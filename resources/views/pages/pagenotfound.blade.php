@extends('layouts.app')

@section('content')
    <div class="" style="margin-top: 5em;">

        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background-color:#307371; color:white;">
                    <h5 class="modal-title ">Page not found</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body ms-3">
                    <p>The page you're looking for could not be found.</p>
                </div>
                <div class="row justify-content-end d-flex me-3 mb-3">
                    <a class="col-5 btn btn-secondary text-center custom-button" href="{{ url('/') }}">Go to homepage </a>
                </div>
            </div>
        </div>
    </div>
@endsection


