'use strict'

//let tags = document.getElementById("created-post-tags");
let submitButton = document.getElementById("submit-button");
//let tagInput = document.getElementById("tag-input");
//let previewButton = document.querySelector("button.preview-post");
let postForm = document.getElementById("create-post-form")
//let modal = document.getElementById("preview-modal");


submitButton.addEventListener("click", function(){
   postForm.submit();
});

/*
previewButton.addEventListener("click", function (){
    modal.classList.add("open");

    let exits = modal.querySelectorAll(".modal-exit");
    exits.forEach(function (exit) {
        exit.addEventListener("click", function (event) {
            event.preventDefault();
            modal.classList.remove("open");
        });
    });

})

 */


$('#select2-tags').select2({
    allowClear: false,
    placeholder: "You're haven't tagged your post yet, add at least 2 different tags",
    theme: 'classic',
    tags: true,
    tokenSeparators: [',', ' '],

    width: '100%'
})


