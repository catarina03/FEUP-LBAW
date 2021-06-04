<div class="modal fade registerModal" id="registerModal" data-bs-backdrop="static" data-bs-keyboard="false"
     tabindex="-1"
     aria-labelledby="registerModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered justify-content-center d-flex" style="width=fit-content;">
        <div class="modal-content login">
            <div class="row justify-content-end me-1 g-0">
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="row justify-content-center d-flex">
                <div class="col-lg-3 col-sm-12 d-none d-lg-flex flex-column  justify-content-center   mx-auto ">
                    <img src="/images/logo-sem-fundo.svg" style="width:150px;">
                </div>
                <div class="col-lg-8 col-sm-12 p-3  justify-content-center d-flex">
                    <form class="row g-0" style="margin-bottom: 5em;margin-top:4em;" method="post"
                    action="{{ route('register') }}">
                    @csrf
                    <label for="email" class=" ms-1 col-form-label-sm text-white">Email</label>
                    <div class=" row">
                        <div class="col-sm-12">
                            <input type="email" class="form-control" id="email" name="email" value="{{ old('email') }}"
                                   placeholder="email" required>
                            @if ($errors->has('email'))
                                <span class="error" style="color:red;">
                                    {{ $errors->first('email') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <label for="username" class=" ms-1 col-form-label-sm text-white">Username</label>
                    <div class=" row">
                        <div class="col-sm-12">
                            <input type="text" class="form-control" id="username" name="username"
                                   value="{{ old('username') }}"
                                   placeholder="username" required>
                            @if ($errors->has('username'))
                                <span class="error" style="color:dark red;">
                                    {{ $errors->first('username') }}
                                </span>
                            @endif
                        </div>
                    </div>
                    <label for="name" class=" ms-1 col-form-label-sm text-white">Name</label>
                    <div class=" row">
                        <div class="col-sm-12">
                            <input type="text" class="form-control" id="name" name="name" placeholder="name"
                                   value="{{ old('name') }}" required>
                            @if ($errors->has('name'))
                                <span class="error" style="color:red;">
                {{ $errors->first('name') }}
                </span>
                            @endif
                        </div>
                    </div>
                    <label for="birthdate" class=" ms-1 col-form-label-sm text-white">Birthdate</label>
                    <div class=" row">
                        <div class="col-sm-12">
                            <input type="date" class="form-control" id="birthdate" name="birthdate"
                                   value="{{ old('birthdate') }}"
                                   placeholder="dd/mm/aaaa"
                                   style="color:grey;" required>
                            @if ($errors->has('birthdate'))
                                <span class="error" style="color:red;">
                {{ $errors->first('birthdate') }}
                </span>
                            @endif
                        </div>
                    </div>
                    <label for="password" class=" ms-1 col-form-label-sm text-white">Password</label>
                    <div class=" row">
                        <div class="col-sm-12">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="*********"
                                   required>
                            @if ($errors->has('password'))
                                <span class="error" style="color:red;">
                {{ $errors->first('password') }}
                </span>
                            @endif
                        </div>
                    </div>
                    <label for="password_confirmation" class=" ms-1 col-form-label-sm text-white">Repeat
                        password</label>
                    <div class=" row">
                        <div class="col-sm-12">
                            <input type="password" class="form-control" id="password_confirmation"
                                   name="password_confirmation"
                                   placeholder="*********" required>
                        </div>
                    </div>
                    <div class="row mt-3  justify-content-center d-flex ">
                        <button type="submit"
                                class="btn btn-sm text-uppercase text-center col-8 btn-secondary authentication-buttons">
                            Register
                        </button>
                    </div>

                    <div class="row mb-2 pt-1 justify-content-center text-center text-white">
                        <p class="m-0 p-0 text-center text-white ">Already have an account yet? <a class="link-auth-hover" href="#"
                                                                                           style="text-decoration:none; color:white; font-weight:500;"
                                                                                           data-bs-dismiss="modal"
                                                                                           id="login"
                                                                                           data-bs-toggle="modal"
                                                                                           data-bs-target="#loginModal">
                                Log in.</a></p>
                    </div>
                    </form>

                </div>

            </div>
        </div>
    </div>
</div>
