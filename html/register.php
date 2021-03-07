<?php
    function draw_register(){
?>

<div class="row col-7 justify-content-center ">
    <!-- add modal her-->
    <div class="modal-dialog-md d-flex col-8 modal-dialog-centered mt-3 ">
        <div class="modal-content login pe-3 ps-3">
            <div class="row justify-content-end  me-1 mt-3 g-0">
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="row ">
                <div class="col-lg-5 col-sm-12 d-none justify-content-center d-lg-flex flex-column ps-3 ms-4 pb-5 mb-5">
                    <img src="/images/logo-sem-fundo.svg" class="mt-5" style="width:90%;">
                </div>
                <div class="col-lg-6 col-sm-12">
                    <form class="row mt-2 ms-5 g-0 ">
                    <label for="email" class=" ms-1 col-form-label-sm text-white">Email</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="email" class="form-control" id="email" placeholder="anasousa@gmail.com">
                            </div>
                        </div>
                        <label for="username" class=" ms-1 col-form-label-sm text-white">Username</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="text" class="form-control" id="name" placeholder="@ana_sousa">
                            </div>
                        </div>
                        <label for="dateofbirth" class=" ms-1 col-form-label-sm text-white">Birthdate</label>
                        <div class=" row">
                            <div class="col-sm-12">
                                <input type="date" class="form-control" id="dateofbirth" placeholder="dd/mm/aaaa" style="color:grey;">
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
                        <div class="row mt-3 col-12  justify-content-center d-flex ">
                            <button type="button"
                                class="btn btn-sm text-uppercase text-center  btn-secondary col-5 authentication-buttons">Register</button>
                        </div>
                        <div class="or-container ms-1 mt-2 pe-5">
                            <div class="line-separator"></div>
                            <div class="or-label">or</div>
                            <div class="line-separator"></div>
                        </div>
                        <div class="row mt-3 mb-2 justify-content-center">
                            <div class="col-9"> <a class="btn btn-sm btn-google btn-block btn-outline d-flex"
                                    href="#"><img src="https://img.icons8.com/color/16/000000/google-logo.png"
                                        class="me-2 mt-1" style="width:10%; height:8%;"> Register with Google</a> </div>
                        </div>

                        <div class="row g-0 mb-4 mt-1">
                            <p class="text-center text-white d-flex ms-1">Already have an account yet? <a href="#"
                                    class="ms-1" style="text-decoration:none; color:white; font-weight:500;">
                                    Log in</a></p>
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