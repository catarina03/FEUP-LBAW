<div class="card col-lg-6 col-sm-12 d-flex justify-content-center bio">
    @if(Auth::user()->id == $user->id)
    <div class="row position-relative" data-toggle="tooltip" data-placement="bottom"
         title="Edit Bio">
        <a
            class="position-absolute top-0 end-0 translate-middle-y d-inline corner-icons pencil-icon">
            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
                 fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                <path
                    d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z" />
            </svg>
        </a>
        <div class="row card-body bio">
            <div class="col-12 bio-text text-center d-flex">
                {{$user->bio}}
            </div>
        </div>
    </div>
    @else
        <div class="row position-relative">
            <div class="row card-body bio">
                <div class="col-12 d-flex justify-content-center">
                    {{$user->bio}}
                </div>
            </div>
        </div>
    @endif
</div>

@if(Auth::user()->id == $user->id)
    <form action="{{ url("api/user/".Auth::user()->id."/edit_bio") }}" method="post" class=" col-lg-12 position-relative ">
        @csrf
        @method('PUT')
        <div class="row position-relative d-none  justify-content-center bio-form">
            <div class="form-group row col-lg-6 justify-content-end">
                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="bio"
                          style="resize:none;"></textarea>
                <input class="current-user-id" name="current-user-id" value="{{Auth::user()->id}}" hidden>
                <button
                        class="btn btn-sm col-2 me-2 mt-1 my-profile-features save-button save-form">Save</button>
            </div>
        </div>
    </form>
@endif
