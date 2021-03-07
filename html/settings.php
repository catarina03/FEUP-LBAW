<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <title>Profile Settings</title>
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
</head>

</head>

<body>
    <?php
    include_once('./navbar.php');
    include_once('./confirm.php');
    draw_nav_bar();
  ?>
    <script src="settings.js" defer></script>
    <div class="row justify-content-start settings g-0 mt-4 ms-5 me-5">
        <div class="col-4 d-none d-lg-flex flex-column" style="padding-left:10%;padding-top:5%;">
            <nav class="nav flex-lg-column">
                <a href="#" class="my-profile-settings justify-content-center nav-link "><i
                        class="bi bi-person-circle fs-4"></i> Profile</a>
                <a href="./settings.php" class="my-profile-settings justify-content-center nav-link active"><i
                        class="bi bi-gear fs-4"></i>
                    Settings</a>
            </nav>
        </div>

        <div class="col-lg-7 col-xl-6 ">
            <form class="row  g-3 mt-5 ">
                <div class="row d-flex mt-2">
                    <h2>Edit Account </h2>
                </div>
                <hr class="solid col-12">
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
                    <div class="col-sm-6 col-lg-6">
                        <div class="row justify-content-center d-flex ">
                            <button type="button"
                                class="btn btn-secondary btn-sm edit-account col-lg-8 col-sm-6 col-xxl-8 change-password">Change
                                Password</button>
                        </div>
                        <div class="card row justify-content-center d-none mt-2 pb-2 col-lg-8 col-sm-6 col-xxl-8 change-password-form"
                            style="margin-left:4.3rem;">
                            <form class="card-body ">
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
                                class="btn btn-secondary btn-sm edit-account col-lg-8 col-sm-6 col-xxl-8"
                                id="delete-account" data-bs-toggle="modal" data-bs-target="#confirm">Delete
                                Account</button>
                        </div>
                    </div>
                </div>
                <div class="row d-flex mt-2">
                    <h2>Social Networks </h2>
                </div>
                <hr class="solid col-12">
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
                        <input type="url" class="form-control" id="instagram"
                            placeholder="Add Instagram to your profile">
                    </div>
                </div>
                <small class="form-text text-muted">Add valid urls.</small>
                <div class="row d-flex mt-2">
                    <h2>Preferences </h2>
                </div>
                <hr class="solid col-12">
                <div class="mb-3 row justify-content-around ms-1">
                    <div class="form-check form-switch">
                        <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts from people I
                            follow by default</label>
                    </div>
                </div>
                <div class="mb-3 row justify-content-around ms-1">
                    <div class="form-check form-switch">
                        <input class="form-check-input switch" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault">Only show posts with tags I follow
                            by default</label>
                    </div>
                </div>
                <div class="mb-3 row justify-content-start">
                    <label for="tags" class="col-sm-3 col-form-label">Tags I follow</label>
                    <div class="col-sm-9 p-0 m-0">
                        <div class="bg-white rounded border  form-control" id="tags">
                            <div class="d-flex justify-content-start">
                                <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">Music <i
                                        class="bi bi-x ms-1"></i></a>
                                <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">News <i
                                        class="bi bi-x ms-1"></i></a>
                            </div>

                        </div>
                    </div>
                </div>

                <div class=" row col-12  justify-content-end d-flex">
                    <a class="edit-account col-1 mt-1 me-1 cancel-button">Cancel</a>
                    <div class="col-1 mt-1 me-1"> or</div>
                    <button type="submit" class="btn btn-secondary btn-sm edit-account col-lg-6 col-sm-4 col-xxl-3"
                        id="save-changes" data-bs-toggle="modal" data-bs-target="#confirm">Save
                        Changes</button>
                </div>

            </form>

        </div>

    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.5/js/select2.full.min.js" defer></script>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
        integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <script defer>
    $('.select2').select2({
        data: ["Piano", "Flute", "Guitar", "Drums", "Photography"],
        tags: true,
        maximumSelectionLength: 10,
        tokenSeparators: [',', ' '],
        placeholder: "Select or type keywords",
    });
    </script>
</body>


</html>