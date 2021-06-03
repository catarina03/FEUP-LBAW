@extends('layouts.app')

@section('content')
    <div class="" style="margin-top: 5em;">

        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background-color:#307371; color:white;">
                    <h5 class="modal-title ">An error occurred</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body ms-3">
                    <p>An error occurred during the action you were trying to execute. Please, trying again later.</p>
                </div>
                <div class="row justify-content-end d-flex me-3 mb-3">
                    <a class="col-5 btn btn-secondary text-center custom-button" href="{{ url('/') }}">Go back </a>
                </div>
            </div>
        </div>
    </div>
@endsection


