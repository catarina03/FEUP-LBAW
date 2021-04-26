@extends('layouts.altart-app')

@section('content')
<div class="container-fluid md-g-0 sm-g-0" style="margin-top:4em;margin-bottom:5em;">
    <div class="row justify-content-start profile settings g-0 mt-4">
        <div class="col-3 col-lg-3 d-none d-lg-flex flex-column" style="padding-top:5%;">
            <nav class="nav flex-lg-column ">
                <a href="./myprofile.php" class="my-profile-settings justify-content-center d-flex nav-link "><i
                        class="bi bi-person-circle me-2"></i>Profile</a>
                <a class="my-profile-settings justify-content-center d-flex nav-link active ms-3"><i
                        class="bi bi-gear me-2"></i>
                    Settings</a>
            </nav>
        </div>

        <div class="col-lg-6 col-12 m-lg-0 mx-auto">

            <div class="row d-flex mt-2">
                <div class="col-lg-12 col-8 pt-2">
                    <h2>Edit Account</h2>
                </div>
                <div class="d-lg-none col-4 pt-2">
                    <a href="./myprofile.php" class="my-profile-settings go-profile"><i
                            class="bi bi-person-circle fs-3 pe-2"></i>Profile</a>
                </div>


            </div>
            <hr class="solid col-12">
            <form action="#">
                <div class="mb-3 row">
                    <label for="name" class="justify-content-center d-flex col-sm-2 col-form-label">Name</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="name" placeholder="Ana Sousa">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="username"
                           class=" justify-content-center d-flex col-sm-2 col-form-label">Username</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="username" placeholder="@ana_sousa">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="email" class="justify-content-center d-flex col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-9">
                        <input type="email" class="form-control" id="email" placeholder="ana_sousa@gmail.com">
                    </div>
                    <small id="emailHelp" class="form-text text-muted ps-5">We'll never share your email with anyone
                        else.</small>
                </div>
                <div class="col-12">
                    <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                        <a href="myprofile.php" style="text-decoration:none;"
                           class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button">Cancel</a>
                        <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                        <button type="button"
                                class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                                id="change-personal-information" data-bs-toggle="modal" data-bs-target="#confirm"
                                style="width:fit-content;">Save Changes
                        </button>
                    </div>
                </div>
            </form>

            <div class="row d-flex mt-3">
                <h2> Social Networks </h2>
            </div>
            <hr class="solid col-12">
            <form action="#">
                <div class="mb-3 row">
                    <label for="twitter" class="justify-content-center d-flex col-sm-2 col-form-label"><i
                            class="fa fa-twitter"></i></label>
                    <div class="col-sm-9">
                        <input type="url" class="form-control" id="twitter" placeholder="Add Twitter to your profile">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="facebook" class="justify-content-center d-flex col-sm-2 col-form-label"><i
                            class="fa fa-facebook"></i></label>
                    <div class="col-sm-9">
                        <input type="url" class="form-control" id="facebook" placeholder="Add Facebook to your profile">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="instagram" class="justify-content-center d-flex col-sm-2 col-form-label"><i
                            class="fa fa-instagram"></i></label>
                    <div class="col-sm-9">
                        <input type="url" class="form-control" id="instagram"
                               placeholder="Add Instagram to your profile">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="linkedin" class="justify-content-center d-flex col-sm-2 col-form-label"><i
                            class="fa fa-linkedin"></i></label>
                    <div class="col-sm-9">
                        <input type="url" class="form-control" id="linkedin" placeholder="Add Linkedin to your profile">
                    </div>
                </div>
                <small class="form-text text-muted ps-5">Add valid urls.</small>
                <div class="col-12">
                    <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                        <a href="myprofile.php" style="text-decoration:none;"
                           class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button">Cancel</a>
                        <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                        <button type="button"
                                class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                                id="change-social-networks" data-bs-toggle="modal" data-bs-target="#confirm"
                                style="width:fit-content;">Save Changes
                        </button>
                    </div>
                </div>
            </form>

            <div class="row d-flex mt-3">
                <h2> Change Password </h2>
            </div>
            <hr class="solid col-12">

            <form action="#">
                <div class="mb-3 row">
                    <label for="currentPassword" class="justify-content-center d-flex col-sm-3 col-form-label">Current
                        Password</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" id="currentPassword" placeholder="*******">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="newPassword" class="justify-content-center d-flex col-sm-3 col-form-label">New
                        Password</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" id="newPassword" placeholder="*******">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="confirmPassword" class="justify-content-center d-flex col-sm-3 col-form-label">Confirm
                        Password</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" id="confirmPassword" placeholder="*******">
                    </div>
                </div>

                <div class="col-12">
                    <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                        <a href="myprofile.php" style="text-decoration:none;"
                           class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button">Cancel</a>
                        <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                        <button type="button"
                                class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                                id="change-password" data-bs-toggle="modal" data-bs-target="#confirm"
                                style="width:fit-content;">Change Password
                        </button>
                    </div>
                </div>
            </form>

            <div class="row d-flex mt-3">
                <h2>Preferences </h2>
            </div>
            <hr class="solid col-12">
            <form action="#">
                <div class="mb-3 row justify-content-start ms-lg-5 ms-4">
                    <div class="form-check form-switch">
                        <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts from people I
                            follow by default</label>
                    </div>
                </div>
                <div class="mb-3 row justify-content-start ms-lg-5 ms-4">
                    <div class="form-check form-switch">
                        <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts with tags I follow
                            by default</label>
                    </div>
                </div>
                <div class="mb-3 row justify-content-start ms-lg-4 ms-0">
                    <label for="tags" class="col-sm-3 col-form-label">Tags I follow</label>
                    <div class="col-sm-8 w-60">
                        <div class="bg-white rounded border form-control" id="tags" style="height:4em;">
                            <div class="d-flex justify-content-start tags">
                                <a class="btn btn-secondary btn-sm d-flex justify-content-center m-2">Music <i
                                        class="bi bi-x ms-1"></i></a>
                                <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">News <i
                                        class="bi bi-x ms-1"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="row justify-content-lg-end justify-content-center d-flex me-lg-4">
                        <a href="myprofile.php" style="text-decoration:none;"
                           class="edit-account col-sm-2 col-md-3 col-lg-1 col-8 mt-1 mb-1 text-center cancel-button">Cancel</a>
                        <div class=" col-md-2 col-lg-1 col-8 mt-1 d-md-block d-none">or</div>
                        <button type="button"
                                class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 pe-5 ps-5"
                                id="change-social-networks" data-bs-toggle="modal" data-bs-target="#confirm"
                                style="width:fit-content;">Save Changes
                        </button>
                    </div>
                </div>
            </form>
            <div class="row d-flex mt-3">
                <h2>Delete Account</h2>
            </div>
            <hr class="solid col-12">

            <div class="row mb-3 justify-content-start ms-lg-5 justify-content-center">
                <a class="btn btn-danger btn-sm edit-account ps-5 pe-5" style="width:fit-content;height:fit-content;" data-bs-toggle="modal" data-bs-target="#confirm">Delete Account</a>
                <span class="col-lg-8 col-12 delete-account-text align-middle text-center ms-2 p-1">
                    Once you delete your account, there is no going back. Please be certain.
                </span>
            </div>

        </div>

    </div>

</div>
@endsection
