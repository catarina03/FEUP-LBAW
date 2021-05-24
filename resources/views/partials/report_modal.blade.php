<div class="modal fade" id="report" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <span hidden class="content_id"></span>
    <span hidden class="content_type"></span>
    <div class="modal-dialog modal-dialog-centered justify-content-center d-flex">
        <div class="modal-content justify-content-center">
            <div class="modal-header" style="background-color:#307371; color:white;">
                <h5 class="modal-title justify-content-center">Report</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Why are you reporting this content?</p>
            </div>


            <div class="row justify-content-center pb-5 report-motives">
                <select class="form-select report_content_select" aria-label="Select a report motive">
                    <option selected>Select a motive</option>
                    <option value="fake">Fake News</option>
                    <option value="innapropriate">Innapropriate content</option>
                    <option value="abusive">Abusive content</option>
                    <option value="hate">Hate Speech</option>
                    <option value="other">Other</option>
                </select>
            </div>
        
            <div class="row justify-content-center d-flex pb-3">
                <button class="col-4 btn btn-secondary me-4" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" class="col-4 btn custom-button me-4 report_button" data-bs-dismiss="modal">Report</button>
            </div>
        </div>
    </div>
</div>

