<?php
    function draw_login(){
?>

<div class="row col-7 justify-content-center ">
    <!-- add modal her-->
    <div class="modal-dialog-md d-flex col-8 modal-dialog-centered mt-3 ">
        <div class="modal-content login">
            <div class="row justify-content-end  me-1 mt-1 g-0">
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="row ">
                <div class="col-lg-5 col-sm-12 d-none d-lg-flex flex-column ps-3 pt-5 mt-5 ms-4">
                    <img src="/images/logo-sem-fundo.svg" class="mt-5" style="width:90%;">
                </div>
                <div class="col-lg-6 col-sm-12">
                    <form class="row mt-4 mb-3 ms-5 g-0 ">
                        <label for="username" class=" ms-1 col-form-label-sm text-white">Username or email</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="text" class="form-control" id="name" placeholder="ana_sousa">
                            </div>
                        </div>
                        <label for="password" class=" ms-1 col-form-label-sm text-white">Password</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="password" class="form-control" id="password" placeholder="*********">
                            </div>
                        </div>
                        <div class="row mt-3 col-12  justify-content-center d-flex ">
                            <button type="button"
                                class="btn btn-sm text-uppercase text-center btn-secondary col-5 authentication-buttons">Log
                                in</button>
                        </div>
                        <div class="or-container ms-1 mt-2 pe-5">
                            <div class="line-separator"></div>
                            <div class="or-label">or</div>
                            <div class="line-separator"></div>
                        </div>
                        <div class="row mt-3 mb-2 justify-content-center">
                            <div class="col-8"> <a class="btn btn-sm btn-google btn-block btn-outline d-flex"
                                    href="#"><img src="https://img.icons8.com/color/16/000000/google-logo.png"
                                        class="me-2 mt-1" style="width:10%; height:8%;"> Log in with Google</a> </div>
                        </div>
                        <div class="row mb-2 justify-content-center text-white">
                            Forgot your password?
                        </div>
                        <div class="row g-0 mb-2 mt-1">
                            <p class="text-center text-white d-flex ms-1">Don't have an account yet? <a href="#"
                                    class="ms-1" style="text-decoration:none; color:white; font-weight:500;">
                                    Register</a></p>
                        </div>

                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
<?php 
    }
?>