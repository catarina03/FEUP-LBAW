<div class="row justify-content-center d-flex my-3 position-relative ">
    <div class="col-lg-3 col-md-3 col-sm-4 mb-3 d-flex justify-content-center ">
        @if(Auth::user()->profile_photo != null)
            <img class="rounded-circle profile-avatar"
                 src="{{ URL::asset($photo) }}"
                 width="200" height="200" alt="avatar">
        @else
            <img class="rounded-circle profile-avatar"
                 src="{{ URL::asset('images/users/default.png') }}"
                 width="200" height="200" alt="avatar">
        @endif
        {{--
        {{ Form::open(array('url' => 'api/user/'.Auth::user()->id.'/edit_photo', 'method' => 'PUT', 'data-toggle'=>'tooltip', 'data-placement'=>'bottom', 'title'=>'Update Profile Photo')) }}
            <div class="form-group">
                <label for="avatar" class="position-absolute d-inline corner-icons"
                       style="transform:translate(-3em, 14em);"><svg xmlns="http://www.w3.org/2000/svg"
                                                                     width="40" height="40" fill="currentColor" class="bi bi-camera-fill"
                                                                     viewBox="0 0 16 16">
                        <path d="M10.5 8.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z" />
                        <path
                            d="M2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2zm.5 2a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9 2.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0z" />
                    </svg></label>
                <input type="file" class="form-control-file" accept=".jpeg,.jpg,.png,.gif"
                       name="avatar" id="avatar" onchange="this.form.submit();" hidden>
            </div>
        {{ Form::close() }}
        --}}

        <form action="{{ url("api/user/".Auth::user()->id."/edit_photo") }}" method="POST" enctype="multipart/form-data" data-toggle="tooltip" data-placement="bottom"
              title="Update Profile Photo">
            @method('PUT')
            @csrf
            <div class="form-group">
                <label for="avatar" class="position-absolute d-inline corner-icons"
                       style="transform:translate(-3em, 14em);"><svg xmlns="http://www.w3.org/2000/svg"
                                                                     width="40" height="40" fill="currentColor" class="bi bi-camera-fill"
                                                                     viewBox="0 0 16 16">
                        <path d="M10.5 8.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z" />
                        <path
                            d="M2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2zm.5 2a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9 2.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0z" />
                    </svg></label>
                <input type="file" class="form-control-file" accept=".jpeg,.jpg,.png,.gif"
                       name="avatar" id="avatar" onchange="this.form.submit();" hidden>
                <input type="text" class="page-info user_id" name="user_id" value="{{ Auth::user()->id }}" hidden>
            </div>
        </form>
    </div>
</div>
