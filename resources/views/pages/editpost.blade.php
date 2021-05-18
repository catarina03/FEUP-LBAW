@extends('layouts.app')

@section('content')
    <div class="createPost row g-0 pt-lg-5 pt-3" style="margin-top: 4em; margin-bottom: 7em;">
        <div class="createPost-icon col-12 col-lg-3 pt-lg-5 pt-3 pb-3 text-center justify-content-center">
            <i class="bi bi-pencil-square d-lg-block d-none" style="font-size:8em;color:#0c1d1c;"></i>
            <h2 style="font-weight:bold;color:#307371;">Edit Post</h2>
        </div>
        <div class="createPost-center col-12 col-lg-7">
            <div class="card create-post-page-post-card justify-content-center d-flex pt-5 pb-5"
                 style="border-radius:5px;">
                <form id="create-post-form" enctype="multipart/form-data" action="{{ url('addpost') }}" method="POST">
                    @csrf

                    {{--TODO
                    @if($errors->any())
                        {!! implode('', $errors->all('<div>:message</div>')) !!}
                    @endif
                    --}}

                    <div class="row justify-content-center">
                        <div class="col-10">
                            <div class="form-group post-comment-input mb-4">
                                <label class="add-comment-label" for="edit-title">Post title</label>
                                <input class="container form-control w-100" name="title" id="title"
                                       value="{{$post['title']}}">
                            </div>
                        </div>
                    </div>


                    <div class="row justify-content-center my-3">
                        <div class="col-10">
                            <div class="row px-0 mx-0">
                                <div class="col-lg-6 col-12 form-group new-post-thumbnail p-0 m-0 me-lg-4">
                                    <label class="form-label" for="postImage">Select post image</label>
                                    <input type="file" class="form-control" name="thumbnail" id="postImage"
                                           value="{{$post->thumbnail}}"/>
                                </div>
                                <div class="col-lg-3 col-sm-6 col-12 form-group category-dropdown mt-lg-3 pt-lg-3 p-1">
                                    <select class="form-select" id="category" name="category" style="cursor:pointer;">
                                        <option value="" disabled selected hidden>Category</option>
                                        @if ($post['category'] == 'music')
                                            <option value="music" selected>Music</option>
                                        @else
                                            <option value="music">Music</option>
                                        @endif
                                        {{-- <option value="Music" >Music</option> --}}
                                        @if ($post['category'] == 'cinema')
                                            <option value="cinema" selected>Cinema</option>
                                        @else
                                            <option value="cinema">Cinema</option>
                                        @endif
                                        {{-- <option value="Cinema" >Cinema</option> --}}
                                        @if ($post['category'] == 'tv Show')
                                            <option value="tv show" selected>TV Show</option>
                                        @else
                                            <option value="tv show">TV Show</option>
                                        @endif
                                        {{-- <option value="TV Show" >TV Show</option> --}}
                                        @if ($post['category'] == 'theatre')
                                            <option value="theatre" selected>Theater</option>
                                        @else
                                            <option value="theatre">Theater</option>
                                        @endif
                                        {{-- <option value="Theater" >Theater</option> --}}
                                        @if ($post['category'] == 'literature')
                                            <option value="literature" selected>Literature</option>
                                        @else
                                            <option value="literature">Literature</option>
                                        @endif
                                        {{-- <option value="Literature" >Literature</option> --}}
                                    </select>
                                </div>
                                <div class="col-lg-2 col-sm-6 col-12 form-group topic-dropdown mt-lg-3 pt-lg-3 p-1">
                                    <select class="form-select" id="topic-dropdown" name="type" style="cursor:pointer;">
                                        <option disabled selected hidden>Type</option>
                                        @if ($post['type'] == 'news')
                                            <option value="News" selected>News</option>
                                        @else
                                            <option value="news">News</option>
                                        @endif
                                        {{-- <option>News</option> --}}
                                        @if ($post['type'] == 'article')
                                            <option value="article" selected>Article</option>
                                        @else
                                            <option value="article">Article</option>
                                        @endif
                                        {{-- <option>Article</option> --}}
                                        @if ($post['type'] == 'review')
                                            <option value="review" selected>Review</option>
                                        @else
                                            <option value="review">Review</option>
                                        @endif
                                        {{-- <option>Review</option> --}}
                                    </select>
                                </div>
                                <div
                                    class="col-lg-7 col-12 form-group spoiler-checkbox p-1 mt-1 mb-0 pb-0 align-self-end">
                                    <input type="checkbox" id="spoiler" name="spoiler-checkbox"
                                           value="{{$post->spoiler}}">
                                    <label for="spoiler">This post contains spoilers</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="container mx-0 px-0 mt-3 create-post-editor-container">
                        <div class="row justify-content-center">
                            <div class="col-10">
                                <label for="mytextarea">Post</label>
                                <textarea id="mytextarea" class="create-post-editor col-auto"
                                          value="{{$post['content']}}" name="content" rows="15"
                                          style="resize:none;">
                                     {{$post['content']}}
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
                                <div
                                    class="bg-white rounded border d-flex align-items-center justify-content-center form-control"
                                    id="tags"
                                    style="height:4em;">
                                    <div class="d-flex justify-content-start tags" id="edited-post-tags">
                                        <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">Music <i
                                                class="bi bi-x ms-1"></i></a>
                                        <a class="btn btn-secondary btn-sm  d-flex justify-content-center m-2">News <i
                                                class="bi bi-x ms-1"></i></a>
                                    </div>
                                    <input class="container form-control w-100 create-post-tag-input" id="tag-input"
                                           name="tag-input" value="{{ old('tag-input') }}">
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center mt-1">
                            <div class="col-10">
                                <p>Min: 2 tags - Max 10 tags</p>
                            </div>
                        </div>
                    </div>

                    <input type="hidden" name="user_id" value="1"/>
                    <div class="row justify-content-center mt-5">
                        <div class="col-10">
                            <div class="row d-flex flex-row">
                                <div class="col-md-auto col-12 me-auto text-center">
                                    <button type="button" class="btn preview-post"><i class="far fa-eye"></i>
                                        Preview
                                    </button>
                                </div>
                                <div class="col-md-auto col-12 text-center">
                                    <button type="button" id="edit-post-cancel-button" class="btn cancel-post">Cancel
                                    </button>
                                </div>
                                <script type="text/javascript" defer>
                                    document.getElementById("edit-post-cancel-button").onclick = function () {
                                        location.href = "/";
                                    };
                                </script>
                                <div class="col-md-auto col-12 text-center">
                                    <input type="submit" class="btn publish-post px-5" id="submit-button"
                                           value="Save Changes">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="{{asset('js/editpost.js')}}" defer></script>
@endsection
