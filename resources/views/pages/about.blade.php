@extends('layouts.altart-app')

@section('content')
<div class="container about-us-card" style="margin-bottom: 5em;margin-top:4em;">
    <div class="row text-left about-rounded justify-content-center pb-0" style="background-color:#8ab5b1;border:none;">
        <div class="col-lg-9 col-11">
            <h1 class="text-center about-us-title mt-1">About Us</h1>
            <div class="card" style="background-color:#8ab5b1;border:none;">
                <div class="card-body about-us">
                    <p>We provide a community website where people can connect and talk to one another
                        about their favourite art-related
                        topics, keeping everything organized and open to everyone.
                    </p>
                    <p style="margin:0;">Here are some general rules:</p>
                    <ul style="margin-bottom:0;">
                        <li>Do not spam;</li>
                        <li>Do not post any fake news;</li>
                        <li>Do not post any abusive content;</li>
                        <li>Do not post any offensive content;</li>
                    </ul>
                    <p style="margin-top:0.5em;"> Any violation to the above rules can be reported, analyzed and deleted
                        by the platform's
                        moderators.</p>
                </div>
            </div>
            <h2 class="jusitfy-content-center text-center">Our Team</h2>
            <div class="row py-5 justify-content-center">
                <div class="col-sm-auto d-flex justify-content-center">
                    <div class="card" style="width: 10rem;background-color:transparent;border:none;">
                        <img src="./images/allan.jpg"
                             class="card-img-top" alt="Allan Sousa Photo" height="170">
                        <div class="card-body text-center">
                            <p class="card-text mb-0 pb-0">Allan</p>
                            <p class="card-text m-0 p-0"> Sousa</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-auto d-flex justify-content-center">
                    <div class="card" style="width: 10rem;background-color:transparent;border:none;">
                        <img src="./images/catarina.jpg"
                             class="card-img-top" alt="Catarina Fernandes Photo" height="170">
                        <div class="card-body text-center">
                            <p class="card-text mb-0 pb-0">Catarina</p>
                            <p class="card-text m-0 p-0">Fernandes</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-auto d-flex justify-content-center">
                    <div class="card" style="width: 10rem;background-color:transparent;border:none;">
                        <img src="./images/mariana.jpg"
                             class="card-img-top" alt="Mariana Truta Photo" height="170">
                        <div class="card-body text-center">
                            <p class="card-text mb-0 pb-0">Mariana</p>
                            <p class="card-text m-0 p-0"> Truta</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-auto d-flex justify-content-center">
                    <div class="card" style="width: 10rem;background-color:transparent;border:none;">
                        <img src="./images/rita.jfif"
                             class="card-img-top" alt="Rita Peixoto Photo" height="170">
                        <div class="card-body text-center">
                            <p class="card-text mb-0 pb-0">Rita</p>
                            <p class="card-text m-0 p-0"> Peixoto</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
