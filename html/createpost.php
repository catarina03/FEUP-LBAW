<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Post</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&family=Roboto&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/45528450c3.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <script src="https://cdn.tiny.cloud/1/08t5y62wss6y2fzascz2trysrq487403jdb54o0kzk3nu9zq/tinymce/5/tinymce.min.js"
        referrerpolicy="origin"></script>
    <script>
    tinymce.init({
        selector: '#mytextarea',
        plugins: ["advlist autolink lists link image charmap print preview anchor"],
        toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
        resize: false
    });
    </script>

    <link rel="stylesheet" href="style/style.css">
</head>

<body class="d-flex flex-column min-vh-100">


    <?php
    function draw_create_post(){
?>

    <div class="createPost row g-0 pt-lg-5 pt-3" style="margin-top: 4em; margin-bottom: 7em;">
        <div class="createPost-icon col-12 col-lg-3 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
            <i class="bi bi-plus-square-dotted d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
            <h2 style="font-weight:bold;color:#307371;">Create Post</h2>
        </div>
        <div class="createPost-center col-12 col-lg-7">
            <div class="card create-post-page-post-card d-flex justify-content-center pt-5 pb-5" style="border-radius:5px;">
                <div class="row justify-content-center">
                    <div class="col-10">
                        <div class="form-group post-comment-input mb-4">
                            <label class="add-comment-label" for="edit-title">Post title</label>
                            <input class="container form-control w-100" id="edit-title" value="">
                        </div>
                    </div>
                </div>


                <div class="row justify-content-center my-3">
                    <div class="col-10">
                        <div class="row px-0 mx-0">
                            <div class="col-lg-6 col-12 form-group new-post-thumbnail p-0 m-0 me-lg-4">
                                <label class="form-label" for="postImage">Select post image</label>
                                <input type="file" class="form-control" id="postImage" />
                            </div>
                            <div class="col-lg-3 col-sm-6 col-12 form-group category-dropdown mt-lg-3 pt-lg-3 p-1">
                                <select class="form-select" id="category-dropdown" style="cursor:pointer;">
                                    <option disabled selected hidden>Category</otion>
                                    <option>Music</option>
                                    <option>Cinema</option>
                                    <option>TV Show</option>
                                    <option>Theater</option>
                                    <option>Literature</option>
                                </select>
                            </div>
                            <div class="col-lg-2 col-sm-6 col-12 form-group topic-dropdown mt-lg-3 pt-lg-3 p-1">
                                <select class="form-select" id="topic-dropdown" style="cursor:pointer;">
                                    <option disabled selected hidden>Topic</otion>
                                    <option>News</option>
                                    <option>Article</option>
                                    <option>Review</option>
                                    <option>Suggestion</option>
                                </select>
                            </div>
                            <div class="col-lg-4 col-12 form-group spoiler-checkbox p-1 mt-1 mb-0 pb-0 align-self-end">
                                <input type="checkbox" id="spoiler" name="spoiler-checkbox" value="spoiler">
                                <label for="spoiler">This post contains spoilers</label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container mx-0 px-0 mt-3 create-post-editor-container">
                    <div class="row justify-content-center">
                        <div class="col-10">
                            <label for="mytextarea">Post</label>
                            <textarea id="mytextarea" class="create-post-editor col-auto" name="mytextarea"
                                style="resize:none;"></textarea>
                        </div>
                    </div>
                    <div class="row justify-content-center mt-1">
                        <div class="col-10">
                            <p><i class="fas fa-exclamation-triangle"></i> Keep in mind that if your post does not
                                follow all website's rules, it may be reported.</p>
                        </div>
                    </div>
                </div>


                <div class="container mx-0 px-0 mt-3 create-post-tags-container">
                    <div class="row justify-content-center">
                        <div class="col-10">
                            <label for="tags" class="col-12 col-form-label">Tags</label>
                            <div class="bg-white rounded border justify-content-center form-control" id="tags"
                                style="height:4em;">
                                <div class="d-flex justify-content-start tags">

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center mt-1">
                        <div class="col-10">
                            <p>Min: 2 tags - Max 10 tags</p>
                        </div>
                    </div>
                </div>


                <div class="container mx-0 px-0 mt-3">
                    <div class="row justify-content-center">
                        <div class="col-10">
                            <label for="tags" class="col-auto ">Add co-authors</label>
                            <div class="bg-white rounded border justify-content-center form-control" id="tags"
                                style="height:4em;">
                                <div class="d-flex justify-content-start tags">

                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row justify-content-center mt-5">
                    <div class="col-10">
                        <div class="row d-flex flex-row">
                            <div class="col-md-auto col-12 me-auto text-center">
                                <button type="button" class="btn preview-post"><i class="far fa-eye"></i>
                                    Preview</button>
                            </div>
                            <div class="col-md-auto col-12 text-center">
                                <button type="button" class="btn cancel-post">Cancel</button>
                            </div>
                            <div class="col-md-auto col-12 text-center">
                                <button type="button" class="btn publish-post px-5">Publish</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <?php
    }
?>





    <?php
        include_once('./navbar.php');
        draw_navbar("authenticated_user");
        draw_create_post();
        include_once('./mobilebar.php');
        draw_mobilebar('authenticated_user');

        include_once('./footer.php');
        draw_footer();
        ?>


</body>


</html>