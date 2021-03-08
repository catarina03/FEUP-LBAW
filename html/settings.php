<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <title>Profile Settings</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="/images/logo-sem-fundo.svg" type="image/png">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
        integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"
        defer>
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="style/custom_navbar.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.5/css/select2.min.css" />
    <link rel="stylesheet" href="style/style.css">
</head>

</head>

<body>
    <?php
    include_once('./confirm.php');
    ?>

    <script src="js/settings.js" defer></script>
    <div class="row justify-content-start profile settings g-0 mt-4 ms-5 ">
        <div class="col-3 col-lg-3 d-none d-lg-flex  flex-column" style="padding-top:5%;">
            <nav class="nav flex-lg-column ">
                <a href="./myprofile.php" class="my-profile-settings  justify-content-center d-flex nav-link  "><i
                        class="bi bi-person-circle fs-4 me-2"></i>Profile</a>
                <a class="my-profile-settings justify-content-center d-flex nav-link active ms-3"><i class="bi bi-gear fs-4 me-2"></i>
                    Settings</a>
            </nav>
        </div>

        <div class="col-lg-6 col-xl-6 col-sm-8 col-md-7">
            <form class="row  g-3 mt-5 me-5 justify-content-center d-flex">
                <div class="row  d-flex mt-2">
                    <h2>Edit Account </h2>
                </div>
                <hr class="solid col-12">
                <div class="mb-3 row">
                    <label for="name" class="justify-content-center d-flex col-sm-2 col-form-label">Name</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="name" placeholder="Ana Sousa">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="username" class=" justify-content-center d-flex col-sm-2 col-form-label">Username</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="username" placeholder="@ana_sousa">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label for="email" class="justify-content-center d-flex col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" id="email" placeholder="ana_sousa@gmail.com">
                    </div>
                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone
                        else.</small>
                </div>
                <div class="mb-3 row justify-content-evenly">
                    <div class="col-sm-6 col-lg-6 ">
                        <div class="row justify-content-center d-flex ">
                            <button type="button"
                                class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xxl-8 change-password mt-2">Change
                                Password</button>
                        </div>
                        <div class=" card card-m-0 row justify-content-center d-none mx-auto mt-2 pb-2 col-lg-9 col-sm-6 col-md-9 col-xxl-8 change-password-form">
                            <form class="card-body d-flex">
                                <div class="form-group">
                                    <label for="currentPassword">Current Password</label>
                                    <input type="password" class="form-control" id="currentPassword"
                                        placeholder="*******">
                                </div>
                                <div class="form-group">
                                    <label for="newPassword">New Password</label>
                                    <input type="password" class="form-control" id="newPassword" placeholder="*******">
                                </div>
                                <div class="form-group">
                                    <label for="confirmnewPassword">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmnewPassword"
                                        placeholder="*******">
                                </div>

                                <div class="form-group justify-content-center d-flex">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-sm-6 col-lg-6 ">
                        <div class="row justify-content-center d-flex">
                            <button type="button"
                                class="btn btn-secondary btn-sm edit-account col-lg-9 col-sm-6 col-md-9 col-xl-8 col-xxl-8 mt-2"
                                id="delete-account" data-bs-toggle="modal" data-bs-target="#confirm">Delete
                                Account</button>
                        </div>
                        
                    </div>
                </div>
                <div class="row d-flex mt-2">
                    <h2>Social Networks </h2>
                </div>
                <hr class="solid col-12">
                <div class="mb-3 row justify-content-start">
                    <label for="twitter" class="justify-content-center d-flex col-sm-2 col-form-label"><i class="fa fa-twitter"></i></label>
                    <div class="col-sm-8">
                        <input type="url" class="form-control" id="twitter" placeholder="Add Twitter to your profile">
                    </div>
                </div>
                <div class="mb-3 row justify-content-start">
                    <label for="facebook" class=" justify-content-center d-flex col-sm-2 col-form-label"><i class="fa fa-facebook"></i></label>
                    <div class="col-sm-8">
                        <input type="url" class="form-control" id="facebook" placeholder="Add Facebook to your profile">
                    </div>
                </div>
                <div class="mb-3 row justify-content-start">
                    <label for="linkedin" class="justify-content-center d-flex col-sm-2 col-form-label"><i class="fa fa-linkedin"></i></label>
                    <div class="col-sm-8">
                        <input type="url" class="form-control" id="linkedin" placeholder="Add LinkedIn to your profile">
                    </div>
                </div>
                <div class="mb-3 row justify-content-start">
                    <label for="instagram" class="justify-content-center d-flex col-sm-2 col-form-label "><i class="fa fa-instagram"></i></label>
                    <div class="col-sm-8">
                        <input type="url" class="form-control" id="instagram"
                            placeholder="Add Instagram to your profile">
                    </div>
                </div>
                <small class="form-text text-muted">Add valid urls.</small>
                <div class="row d-flex mt-2">
                    <h2>Preferences </h2>
                </div>
                <hr class="solid col-12">
                <div class="mb-3 row justify-content-around ms-5">
                    <div class="form-check form-switch">
                        <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts from people I
                            follow by default</label>
                    </div>
                </div>
                <div class="mb-3 row justify-content-around ms-5">
                    <div class="form-check form-switch">
                        <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts with tags I follow
                            by default</label>
                    </div>
                </div>
                <div class="mb-3 row justify-content-start ms-4">
                    <label for="tags" class="col-sm-3 col-form-label">Tags I follow</label>
                    <div class="col-sm-9 p-0 m-0">
                        <div class="bg-white rounded border  form-control" id="tags" style="height:4em;">
                            <div class="d-flex justify-content-start tags">
                                <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">Music <i
                                        class="bi bi-x ms-1"></i></a>
                                <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">News <i
                                        class="bi bi-x ms-1"></i></a>
                            </div>

                        </div>
                    </div>
                </div>

                <div class=" row col-12  justify-content-center d-flex mt-5">
                    <a class="edit-account  col-sm-2 col-md-3 col-lg-1 col-8 mt-1 cancel-button">Cancel</a>
                    <div class=" col-md-2 col-lg-1 col-sm-1 col-8 mt-1  "> or</div>
                    <button type="submit"
                        class="btn btn-secondary btn-sm edit-account  col-md-6 col-sm-3   col-lg-3 col-xxl-3 col-6"
                        id="save-changes" data-bs-toggle="modal" data-bs-target="#confirm">Save
                        Changes</button>
                </div>

            </form>

        </div>

    </div>

</body>


</html>