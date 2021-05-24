'use strict'

//let tags = document.getElementById("created-post-tags");
let submitButton = document.getElementById("submit-button");
//let tagInput = document.getElementById("tag-input");
let postForm = document.getElementById("create-post-form")

/*
submitButton.addEventListener("click", function (){
    let inputArray = [];
    for (let i = 0; i < tags.children.length; i++){
        inputArray.push(tags.children.item(i).textContent.trim());
    }
    document.getElementById("tag-input-form").value = inputArray;
    console.log(document.getElementById("tag-input-form"));
});
 */

submitButton.addEventListener("click", function(){
   postForm.submit();
});

/*
submitButton.onclick = function() {
    let inputArray = [];
    for (let i = 0; i < tags.children.length; i++){
        inputArray.push(tags.children.item(i).textContent.trim());
    }
    document.getElementById("tags").value = inputArray;
    console.log(document.getElementById("tag-input-form"));
};
 */




/*
postForm.addEventListener("submit", function (){
    let inputArray = [];
    for (let i = 0; i < tags.children.length; i++){
        inputArray.push(tags.children.item(i).textContent.trim());
    }
    document.getElementById("tags").value = inputArray;
    console.log(document.getElementById("tag-input-form"));
})


document.addEventListener("load", function (){
    let input = tagInput.value;
    tags.innerHTML += writeTag(document.getElementById("tag-input-form"));
})



tagInput.addEventListener("keyup", function(event){
    let code;
    if (event.key !== undefined) {
        code = event.key;
    } else if (event.keyIdentifier !== undefined) {
        code = event.keyIdentifier;
    } else if (event.keyCode !== undefined) {
        code = event.keyCode;
    }
    if (code === " " || code === "Spacebar" || code === 32) {
        addTag();
    }
});

function addTag(){
    let input = tagInput.value;
    tags.innerHTML += writeTag(input);
    document.querySelectorAll("i.post-tag-remover").forEach( item => {
         item.addEventListener('click', event => {
             console.log(event.target);
             item.parentElement.remove();
         })
    });
    tagInput.value = '';
}

function writeTag(tag){
    return '<a class="col post-tag btn btn-secondary btn-sm d-flex justify-content-center m-2">'
        + tag
        + '<i class="bi bi-x ms-1 post-tag-remover"></i></a>';
}


 */






$('#select2-tags').select2({
    allowClear: false,
    placeholder: "You're haven't tagged your post yet, add at least 2 different tags",
    theme: 'classic',
    tags: true,
    tokenSeparators: [',', ' '],

    width: '100%'
})


/*
$(document).ready(function() {
    $('.js-example-basic-multiple').select2();
});
*/


/*
$(".js-example-tags").select2({
    tags: true
});

// In your Javascript (external .js resource or <script> tag)
$(document).ready(function() {
    $('.js-example-tags').select2();
});
*/
