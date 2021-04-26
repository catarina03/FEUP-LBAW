@extends('layouts.altart-app')

@section('content')
<div class="row justify-content-center my-3 position-relative d-flex profile userprofile mx-2">
    <div class="col-lg-3 col-sm-4  d-flex justify-content-center ">
        <img class="rounded-circle profile-avatar"
             src="https://demos.creative-tim.com/argon-dashboard-pro/assets/img/theme/team-4.jpg" width="200"
             height="200" alt="avatar">
    </div>
</div>
<div class="row justify-content-center d-flex mb-5 userprofile mx-2">
    <div class="card card-profile col-lg-7 col-xl-9 col-sm-9" style="border-radius:2%;">
        <div class="row justify-content-center mt-1">
            <div class="col-lg-2 col-sm-3 d-flex justify-content-center">
                <h5 class="card-title mt-5 profile-name">Ana Sousa</h5>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-2 d-flex justify-content-center">
                <p class="profile-username">@ana_sousa</p>
            </div>
        </div>


        <div class="card-body">
            <div class="row justify-content-center ">
                <div class="col-lg-6 col-sm-12">
                    <div class="row justify-content-around statistics-profile">
                        <div class="col-4 d-flex justify-content-center ">
                            <p>800 Followers</p>
                        </div>
                        <div class="col-4  d-flex justify-content-center">
                            <p>500 Following</p>
                        </div>
                        <div class="col-4  d-flex justify-content-center">
                            <p>900 Likes</p>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row justify-content-center">
                <div class="card col-lg-6  d-flex justify-content-center"
                     style="background-color:#8ab5b1; border:none;">
                    <div class="row position-relative">
                        <div class=" row card-body bio ">
                            <div class="col-12  d-flex justify-content-center">
                                I am a senior editor and specialized in covering the evolution and impact of
                                brands.
                                Bidibodibi
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mt-3 ">
                <button type="button"
                        class="btn btn-secondary col-lg-3 col-sm-6 btn-sm profile-features follow">Follow</button>
                <button type="button"
                        class="btn btn-secondary col-lg-3 col-sm-6 btn-sm  profile-features block">Block</button>
            </div>
            <div class="row justify-content-center mt-2">
                <div class="col-lg-2 col-sm-4  d-flex justify-content-center">
                    <a href="https://www.instagram.com/"
                       class="btn btn-secondary btn-sm social-media d-flex justify-content-center">
                        <i class="bi bi-instagram"></i>
                    </a>
                    <a href="https://www.twitter.com/"
                       class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                        <i class="bi bi-twitter"></i>
                    </a>
                    <a href="https://www.facebook.com/"
                       class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                        <i class="bi bi-facebook"></i>
                    </a>
                    <a href="https://www.linkedin.com/"
                       class="btn btn-secondary btn-sm  social-media d-flex justify-content-center">
                        <i class="bi bi-linkedin"></i>
                    </a>
                </div>
            </div>
            <div class="postsCards row justify-content-start mt-5">
                <div class="col-12 col-lg-4 col-md-6 col-xl-4 mb-4">
                    <div class="card h-100">

                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                             alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        <div class="savePost" data-toggle="tooltip" data-placement="bottom"
                             title="Save/Unsave Post">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>

                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes
                                the Shock'
                                Video </h5>
                            <small>by <a id="authorNamenothover">Ana Sousa</a>,
                                FEBRUARY 28, 2021</small>
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new
                                song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe.
                                The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                    <div class="card h-100">

                        <img src="https://ichef.bbci.co.uk/news/976/cpsprodpb/1572B/production/_88615878_976x1024n0037151.jpg"
                             height="200" class="card-img-top" alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        <div class="savePost" data-toggle="tooltip" data-placement="bottom"
                             title="Save/Unsave Post">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>

                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Mick Jagger Celebrates 150 Years of the Royal Albert Hall
                                in New Video
                            </h5>
                            <small>by <a id="authorNamenothover">Ana Sousa</a>,
                                FEBRUARY 23, 2021</small>
                            <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts
                                Hall in
                                celebration
                                of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second
                                film includes
                                scenes
                                of the empty venue during the pandemic. "I would like to take this
                                <strong>(read
                                    more)</strong>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                    <div class="card h-100">

                        <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHw%3D&w=1000&q=80"
                             height="200" class="card-img-top" alt="...">
                        <div class="categoryTag">
                            <h6>Literature</h6>
                        </div>
                        <div class="savePost" data-toggle="tooltip" data-placement="bottom"
                             title="Save/Unsave Post">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>

                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Hillary Clinton and Louise Penny to Write Political
                                Thriller</h5>
                            <small>by <a id="authorNamenothover">Ana Sousa</a>,
                                FEBRUARY 23, 2021</small>
                            <p class="card-text">Mick Jagger narrates a new film on London’s Royal Alberts
                                Hall in
                                celebration
                                of the iconic venue’s 150th birthday. Directed by Tom Harper, the 90-second
                                film includes
                                scenes
                                of the empty venue during the pandemic. "I would like to take this
                                <strong>(read
                                    more)</strong>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                    <div class="card h-100">

                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                             alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        <div class="savePost" data-toggle="tooltip" data-placement="bottom"
                             title="Save/Unsave Post">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>

                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes
                                the Shock'
                                Video </h5>
                            <small>by <a id="authorNamenothover">Ana Sousa</a>,
                                FEBRUARY 28, 2021</small>
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new
                                song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe.
                                The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                    <div class="card h-100">

                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                             alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        <div class="savePost" data-toggle="tooltip" data-placement="bottom"
                             title="Save/Unsave Post">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>

                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes
                                the Shock'
                                Video </h5>
                            <small>by <a id="authorNamenothover">Ana Sousa</a>,
                                FEBRUARY 28, 2021</small>
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new
                                song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe.
                                The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 col-lg-4 col-xl-4 mb-4">
                    <div class="card h-100">

                        <img src="https://www.w3schools.com/w3css/img_lights.jpg" height="200" class="card-img-top"
                             alt="...">
                        <div class="categoryTag">
                            <h6>Music</h6>
                        </div>
                        <div class="savePost" data-toggle="tooltip" data-placement="bottom"
                             title="Save/Unsave Post">
                            <i class="bi bi-bookmark-plus-fill" style="font-size:3em;"></i>
                        </div>

                        <div class="infoPosts">
                            <i class="far fa-eye"></i><span>3</span>
                            <i class="far fa-thumbs-up"></i><span>2</span>
                        </div>

                        <div class="card-body">
                            <h5 class="card-title">Green Day Offers Up Punk-Inspired Aerobics in ‘Here Comes
                                the Shock'
                                Video </h5>
                            <small>by <a id="authorNamenothover">Ana Sousa</a>,
                                FEBRUARY 28, 2021</small>
                            <p class="card-text">On Saturday (Feb. 20), the rock band premiered their new
                                song "Here
                                Comes
                                the
                                Shock" as part of the National Hockey League's outdoor games in Lake Tahoe.
                                The
                                accompanying
                                video
                                features "Punk Rock Aerobics" cofounder Hilken <strong>(read more)</strong>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-center">
                <div class="pagination">
                    <a href="#">&laquo;</a>
                    <a href="#"  class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">&raquo;</a>
                </div>
            </div>
        </div>
    </div>

</div>
@endsection
