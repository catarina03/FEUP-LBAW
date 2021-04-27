@extends('layouts.altart-app')

@section('content')
<div class="container faq-card">
    <div class="col-12 text-left" style="background-color:#8ab5b1;border-radius:2%;min-height:800px;">
        <h1 class="text-center faq-title ">Frequently Asked Questions</h1>
        <!--Title-->
        <div class="row justify-content-center d-flex pt-4 pb-4">
            <div class="faq_questions col-lg-9 col-11">
                <!--Question row-->
                <div class="question mt-5">
                    <div class="question-text p-1">
                        <h4> Why do I need to create an account? </h4>
                    </div>
                    <div class="answer fs-4">
                        <p> Even though you can view all posts without an account, you need one in order to be able to
                            comment, like, dislike, follow other users and follow your
                            favorite tags. </p>
                    </div>
                </div>
                <div class="question mt-5">
                    <div class="question-text p-1">
                        <h4> How can I report a comment or post? </h4>
                    </div>
                    <div class="answer fs-4">
                        <p> Very nice explanation... </p>
                    </div>
                </div>

                <div class="question  mt-5">
                    <div class="question-text p-1">
                        <h4> What happens to a post that gets reported? </h4>
                    </div>
                    <div class="answer fs-4">
                        <p> The post will be marked, one of the moderators is going to
                            analyze it and decide if it indeed breaks the rules of the site.
                        </p>
                    </div>
                </div>
                <div class="question  mt-5">
                    <div class="question-text p-1">
                        <h4> Where can I change my preferences? </h4>
                    </div>
                    <div class="answer fs-4">
                        <p> On users' profile, in settings
                        </p>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
@endsection
