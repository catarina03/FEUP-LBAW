@extends('layouts.altart-app')

@section('content')
<div class="createPost row g-0 pt-lg-5 pt-3" style="margin-top: 4em; margin-bottom: 7em;">
    <div class="createPost-icon col-12 col-lg-3 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
        <i class="bi bi-pencil-square d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
        <h2 style="font-weight:bold;color:#307371;">Edit Post</h2>
    </div>
    <form class="createPost-center col-12 col-lg-7" method="post" >
        <div class="card create-post-page-post-card justify-content-center d-flex pt-5 pb-5" style="border-radius:5px;">
            <div class="row justify-content-center">
                <div class="col-10">
                    <div class="form-group post-comment-input mb-4">
                        <label class="add-comment-label" for="edit-title">Post title</label>
                        <input class="container form-control w-100" id="edit-title"
                            value="Mick Jagger Celebrates 150 Years of the Royal Albert Hall in New Video">
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
                            <select class="form-select" id="category-dropdown">
                                <option disabled>Category</otion>
                                <option selected>Music</option>
                                <option>Cinema</option>
                                <option>TV Show</option>
                                <option>Theater</option>
                                <option>Literature</option>
                            </select>
                        </div>
                        <div class="col-lg-2 col-sm-6 col-12 form-group topic-dropdown mt-lg-3 pt-lg-3 p-1">
                            <select class="form-select" id="topic-dropdown">
                                <option disabled>Type</otion>
                                <option selected>News</option>
                                <option>Article</option>
                                <option>Review</option>
                                <option>Suggestion</option>
                            </select>
                        </div>
                        <div class="col-lg-7 col-12 form-group spoiler-checkbox p-1 mt-1 mb-0 pb-0 align-self-end">
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
                        <textarea id="mytextarea" class="create-post-editor col-auto" name="mytextarea" rows="15"
                            style="resize:none;">
                                Mick Jagger narrates a new film on London’s Royal Alberts Hall in celebration of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second film includes scenes of the empty venue during the pandemic.
    <br>“I would like to take this opportunity to wish the Royal Albert Hall a very happy 150th birthday and look forward to the future, seeing and listening to many fantastic artists and musicians performing onstage at this iconic venue,” Jagger says.
    <br>“I have desperately missed live performance — there is something electric and fundamentally human about the shared experience of being in a room surrounded by other people, part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty, but what makes it truly special is the connection it fosters through those shared experiences. That is what this film is about: Not only a celebration of performances from the Hall’s glorious past, but also the sense of anticipation of some of the things to look forward to when we can be together again.”
    <br>...<br>... <br>“I have desperately missed live performance — there is something electric and fundamentally human about the shared experience of being in a room surrounded by other people, part of an audience,” Harper added. “The Royal Albert Hall is a magnificent building even when it’s empty, but what makes it truly special is the connection it fosters through those shared experiences. That is what this film is about: Not only a celebration of performances from the Hall’s glorious past, but also the sense of anticipation of some of the things to look forward to when we can be together again.”
                            </textarea>
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
                                <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">Music <i
                                        class="bi bi-x ms-1"></i></a>
                                <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">News <i
                                        class="bi bi-x ms-1"></i></a>
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
                            <input type="submit" class="btn publish-post px-5" value="Save Changes">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>
@endsection