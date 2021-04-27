@extends('layouts.app')

@section('content')
<div class="modal fade" id="register" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
    aria-labelledby="staticBackdropLabel" aria-hidden="true">
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
                <div class="col-lg-8 col-sm-12">
                    <form class="row mt-4 mb-3 ms-5 g-0" method="post" action="">
                        <label for="email" class=" ms-1 col-form-label-sm text-white">Email</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="email" class="form-control" id="email" placeholder="anasousa@gmail.com">
                            </div>
                        </div>
                        <label for="username" class=" ms-1 col-form-label-sm text-white">Username</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="text" class="form-control" id="username" placeholder="@ana_sousa">
                            </div>
                        </div>
                        <label for="name" class=" ms-1 col-form-label-sm text-white">Name</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="text" class="form-control" id="name" placeholder="Ana Sousa">
                            </div>
                        </div>
                        <label for="dateofbirth" class=" ms-1 col-form-label-sm text-white">Birthdate</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="date" class="form-control" id="dateofbirth" placeholder="dd/mm/aaaa"
                                    style="color:grey;">
                            </div>
                        </div>
                        <label for="password" class=" ms-1 col-form-label-sm text-white">Password</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="password" class="form-control" id="password" placeholder="*********">
                            </div>
                        </div>
                        <label for="repeatpassword" class=" ms-1 col-form-label-sm text-white">Repeat password</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="password" class="form-control" id="repeatpassword" placeholder="*********">
                            </div>
                        </div>
                        <div class="row mt-3  justify-content-center d-flex ">
                            <button type="button"
                                class="btn btn-sm text-uppercase text-center col-8 btn-secondary  authentication-buttons">Register</button>
                        </div>

                        <div class="or-container ms-1 mt-2 pe-5">
                            <div class="line-separator"></div>
                            <div class="or-label">or</div>
                            <div class="line-separator"></div>
                        </div>
                        <div class="row mt-3 mb-2 justify-content-center ">
                            <div class="col-10"> <a
                                    class="btn btn-sm btn-google btn-block btn-outline justify-content-center d-flex"
                                    href="#"><img src="https://img.icons8.com/color/16/000000/google-logo.png"
                                        class="me-2 " style="width:10%; height:8%;"> Register with Google</a> </div>
                        </div>


                        <div class="row g-0 mb-4 mt-1 d-flex justify-content-center">
                            <p class="text-center text-white ">Already have an account yet? <a href="#"
                                    style="text-decoration:none; color:white; font-weight:500;">
                                    Log in.</a></p>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
@endsection
