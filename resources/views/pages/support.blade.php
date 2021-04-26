@extends('layouts.altart-app')

@section('content')
<div class="container support-card" style="margin-bottom: 5em; margin-top: 4em;">
    <section class="text-left" style="background-color:#8ab5b1;border-radius:2%;">
        <!--Title-->
        <h1 class="text-center support-title">Support</h1>
        <form class="row faq_questions justify-content-center">
            <div class="col-lg-9 col-11 mb-4">
                <!--Question row-->
                <div class="row pb-4">
                    <div class="w-100 question-col">
                        <!--Column with the button needed to make the specified effect in the InVision project-->
                        <div class="form-group">
                            <label for="exampleFormControlTextarea1">Please, tell us more about your problem:</label>
                            <textarea class="form-control mt-2" id="support-text" rows="3"
                                placeholder="Briefly describe your problem here" style="resize:none;" required></textarea>
                        </div>
                    </div>
                </div>
                <div class="row pb-4">
                    <div class="question-col">
                        <div class="form-group">
                            <label for="support-browser">In what browser are you experiencing this problem?</label>
                            <select class="form-select support-form mt-2" id="support-browser" style="cursor:pointer;" required>
                                <option value="" disabled selected hidden>Choose your browser</option>
                                <option value="google">Google Chrome</option>
                                <option value="firefox">Firefox Web</option>
                                <option value="safari">Safari</option>
                                <option value="edge">Microsoft Edge</option>
                                <option value="opera">Opera</option>
                            </select>
                        </div>
                    </div>
                </div>
                <!-- End of question row-->
                <div class="row pb-4">
                    <div class="question-col">
                        <div class="form-group">
                            <label for="support-browser">How often do you experience this problem?</label>
                            <select class="form-select support-form mt-2" id="support-freq" style="cursor:pointer;" required>
                                <option value="" disabled selected hidden>Select an option</option>
                                <option value="rarely">Rarely</option>
                                <option value="often">Often</option>
                                <option value="very_often"> Very Often</option>
                            </select>
                            <label class="mt-4" for="support-browser">How much does this problem impact your
                                experience?</label>
                        </div>
                    </div>
                </div>


                <div class="row pb-4 justify-content-center">
                    <div class="col-lg-4 col-sm-12 rate-col">
                        <p class="sm-paragraph d-md-none d-lg-none" style="text-center;padding-left:30%;"> Not much </p>
                        <p class="md-paragraph" style="padding-right:0;"> Not much </p>
                    </div>

                    <div class="col-lg-4 col-sm-12 rate-col-radio">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input inner faq-i" type="radio" name="inlineRadioOptions" id="opt1"
                                value="1" style="cursor:pointer;">
                            <label class="form-check-label" for="opt1"></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input inner faq-i" type="radio" name="inlineRadioOptions" id="opt2"
                                value="2" style="cursor:pointer;">
                            <label class="form-check-label" for="opt2"></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input inner faq-i" type="radio" name="inlineRadioOptions" id="opt3"
                                value="3" style="cursor:pointer;">
                            <label class="form-check-label" for="opt3"></label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input inner faq-i" type="radio" name="inlineRadioOptions" id="opt4"
                                value="4" style="cursor:pointer;">
                            <label class="form-check-label" for="opt4"></label>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-12 rate-col">
                        <p class="sm-paragraph-2 d-md-none d-lg-none"> Very
                            Negatively
                        </p>
                        <p class="md-paragraph-2"> Very Negatively </p>
                    </div>
                </div>
                <div class="row pb-4">
                    <div class="w-100 question-col">
                        <div class="form-group">
                            <label for="contactSupport">How can we contact you?</label>
                            <input class="form-control mt-2" type="email" id="email" name="email"
                                placeholder="example@example.com" style="background-color:#fcf3ee;" required>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <input type="submit" class="btn support-button" value="Submit">
                </div>
            </div>
        </form>
    </section>
</div>
@endsection


