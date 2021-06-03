'use strict'

let submitButton = document.getElementById("submit-button");
let postForm = document.getElementById("create-post-form")



submitButton.addEventListener("click", function(){
   postForm.submit();
});


$('#select2-tags').select2({
    allowClear: false,
    placeholder: "You're haven't tagged your post yet, add at least 2 different tags",
    theme: 'classic',
    tags: true,
    tokenSeparators: [',', ' '],

    width: '100%'
})


