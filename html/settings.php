<?php
    function draw_profile_settings(){
?>
<div class="row justify-content-start settings g-0 mt-4 ms-5">
    <div class="col-4 d-none d-lg-flex flex-column" style="padding-left:15%;padding-top:5%;">
            <a href="profile.php" class="my-profile-settings"><i class="bi bi-person-circle fs-4"></i> Profile</a>
            <a href="#" class="my-profile-settings" style="font-weight:bold;"><i class="bi bi-gear fs-4"></i> Settings</a>
    </div>

    <div class="col-lg-5 col-sm-10">
        <form class="row  g-3 mt-5 ">
            <div class="row d-flex mt-2">
                <h2>Edit Account </h2>
            </div>
            <hr class="solid">
            <div class="mb-3 row">
                <label for="name" class="col-sm-2 col-form-label">Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="name" placeholder="Ana Sousa">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="username" class="col-sm-2 col-form-label">Username</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="username" placeholder="@ana_sousa">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="email" class="col-sm-2 col-form-label">Email</label>
                <div class="col-sm-10">
                    <input type="email" class="form-control" id="email" placeholder="ana_sousa@gmail.com">
                </div>
                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone
                    else.</small>
            </div>
            <div class="mb-3 row justify-content-evenly">
                <div class="col-sm-6 col-lg-3">
                    <button type="submit" class="btn btn-secondary btn-sm edit-account">Change Password</button>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <button type="submit" class="btn btn-secondary btn-sm edit-account">Delete Account</button>
                </div>
            </div>
            <div class="row d-flex mt-2">
                <h2>Social Networks </h2>
            </div>
            <hr class="solid">
            <div class="mb-3 row justify-content-around">
                <label for="twitter" class="col-sm-2 col-form-label"><i class="fa fa-twitter"></i></label>
                <div class="col-sm-10">
                    <input type="url" class="form-control" id="twitter" placeholder="Add Twitter to your profile">
                </div>
            </div>
            <div class="mb-3 row justify-content-around">
                <label for="facebook" class="col-sm-2 col-form-label"><i class="fa fa-facebook"></i></label>
                <div class="col-sm-10">
                    <input type="url" class="form-control" id="facebook" placeholder="Add Facebook to your profile">
                </div>
            </div>
            <div class="mb-3 row justify-content-around">
                <label for="linkedin" class="col-sm-2 col-form-label"><i class="fa fa-linkedin"></i></label>
                <div class="col-sm-10">
                    <input type="url" class="form-control" id="linkedin" placeholder="Add LinkedIn to your profile">
                </div>
            </div>
            <div class="mb-3 row justify-content-around">
                <label for="instagram" class="col-sm-2 col-form-label"><i class="fa fa-instagram"></i></label>
                <div class="col-sm-10">
                    <input type="url" class="form-control" id="instagram" placeholder="Add Instagram to your profile">
                </div>
            </div>
            <small class="form-text text-muted">Some message about the urls.</small>
            <div class="row d-flex mt-2">
                <h2>Preferences </h2>
            </div>
            <hr class="solid">
            <div class="mb-3 row justify-content-around">
                <div class="form-check form-switch">
                    <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                    <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts from people I
                        follow by default</label>
                </div>
            </div>
            <div class="mb-3 row justify-content-around">
                <div class="form-check form-switch">
                    <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                    <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts with tags I follow
                        by default</label>
                </div>
            </div>
            <!--<div class="form-check">
                <div class=" tag card col-4">
                    <div class="card-header  d-flex justify-content-end">
                        <p>Tag name</p>
                        <button type="button" class="btn-close" aria-label="Close"></button>
                    </div>

                </div>-->


            <div class=" row col-12  justify-content-end d-flex">
                <a class="edit-account col-1 mt-1 me-1 cancel-button">Cancel</a>
                <div class="col-1 mt-1 me-1"> or</div>
                <button type="submit" class="btn btn-secondary btn-sm edit-account col-2 ">Save
                    Changes</button>
            </div>

        </form>

    </div>

</div>



<?php
    }
?>