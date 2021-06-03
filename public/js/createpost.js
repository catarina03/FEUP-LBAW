'use strict'

document.getElementById("submit-button").onclick = function() {
    let inputArray = [];
    for (let i = 0; i < tags.children.length; i++){
        inputArray.push(tags.children.item(i).textContent.trim());
    }
    document.getElementById("tag-input").value = inputArray;
};


let tags = document.getElementById("created-post-tags");

let tagInput = document.getElementById("tag-input");
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
    tagInput.value = '';
}

function writeTag(tag){
    let content =
        '<a class="btn btn-secondary btn-sm d-flex justify-content-center m-2">'
        + tag
        + '<i class="bi bi-x ms-1"></i></a>';

    return content;
}
