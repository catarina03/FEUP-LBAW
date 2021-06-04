<div class="modal fade" id="loginModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="loginModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered justify-content-center d-flex " style="width=fit-content;">
        <div class="modal-content login">
            <div class="row justify-content-end me-1 mt-1 g-0">
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="row justify-content-center d-flex">

                <div class="col-lg-3 col-sm-12 d-none pe-3 d-lg-flex flex-column justify-content-center mx-auto">
                    <img src="/images/logo-sem-fundo.svg" style="width:150px;" alt="AltArt">
                </div>
                <div class="col-lg-8 col-sm-12">
                    <form class="row mt-4 ps-3 mb-3 me-2 g-0" method="POST" action=" {{ route('login') }}">
                        @csrf
                        @if ($errors->any())
                            @foreach ($errors->all() as $error)
                                <div class="col-12 d-flex align-items-center">
                                    <i class="bi bi-exclamation-triangle"></i>
                                    <span style="color: darkred;font-weight: bold; width: 100%">{{$error}}</span>
                                </div>
                            @endforeach
                        @endif
                        <label for="username" class=" ms-1 col-form-label-sm text-white">Username</label>
                        <div class="row">
                            <div class="col-sm-12">
                                <input type="text" class="form-control" id="username" name="username" value="{{ old('username') }}" placeholder="username" required>
                            </div>
                        </div>
                        <label for="password" class="ms-1 col-form-label-sm text-white">Password</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="password" class="form-control" id="password" name="password" placeholder="*********">
                            </div>
                        </div>
                        <div class="row mt-3 pb-3 justify-content-center d-flex ">
                            <button type="submit"
                                    class="btn btn-sm text-uppercase text-center col-8 btn-secondary authentication-buttons login-modal-button">
                                Login
                            </button>
                        </div>
                        <div class="row mb-2 pt-1 justify-content-center text-center text-white" >
                            <a class="black-link link-auth-hover" href="forgot_password" style="text-decoration: none;color:white;max-width: fit-content;"> Forgot your password? </a>
                        </div>
                        <div class="row g-0 mb-4 ps-0 ms-0 d-flex ">
                            <p class="text-center text-white ps-0 ms-0 ">Don't have an account yet? <a class="link-auth-hover" href="#"
                                                                                             style="text-decoration:none; color:white; font-weight:500;"
                                                                                             data-bs-dismiss="modal"
                                                                                             id="register"
                                                                                             data-bs-toggle="modal"
                                                                                             data-bs-target="#registerModal">
                                    Register.</a></p>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

