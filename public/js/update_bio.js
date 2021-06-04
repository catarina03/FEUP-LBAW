let pencil = document.querySelector(".my-profile .pencil-icon");
let save = document.querySelector(".my-profile .save-form");
let userId = document.querySelector("input.current-user-id")

if (pencil != null) {
    pencil.addEventListener("click", callEditBioForm)
}

function callEditBioForm() {
    let bio = document.querySelector(".my-profile .bio");
    let bio_form = document.querySelector(".my-profile .bio-form");
    setFormVisible(bio, bio_form)
}

if (save != null) {
    save.addEventListener("click", prepareEditBioRequest);
}

function prepareEditBioRequest(e){
    e.preventDefault();
    let getUrl = window.location;
    let bio_text = document.querySelector("textarea.form-control");
    makeRequest("put", getUrl.protocol + "//" + getUrl.host  + "/api/user/"+userId.value+"/edit_bio", update_bio, encodeForAjax({'bio':bio_text.value}))
}

function update_bio(status, response){
    console.log(response)
    if(status === 200){
        let bio = document.querySelector(".my-profile .bio");
        let bio_form = document.querySelector(".my-profile .bio-form");
        setFormHidden(bio, bio_form)

        let bioContent = JSON.parse(response)
        let bioPartial = document.querySelector('div.profile-bio-div');
        bioPartial.innerHTML = bioContent['profilebio'];

        pencil = document.querySelector(".my-profile .pencil-icon");
        save = document.querySelector(".my-profile .save-form");
        pencil.addEventListener("click", callEditBioForm)
        save.addEventListener("click", prepareEditBioRequest);
    }
    else if(status === 400){
        alert(response)
    } else{
        alert("Error fetching api: " + status)
    }
}

function setFormVisible(bio, bio_form){
    if (bio.classList.contains("d-flex")) {
        bio.classList.remove("d-flex");
        bio.classList.add("d-none");
    }
    if (bio_form.classList.contains("d-none")) {
        bio_form.classList.remove("d-none");
        bio_form.classList.add("d-flex");

        let bio_text = document.querySelector(".my-profile .bio .bio-text")
        let bio_form_text = document.querySelector(".my-profile .bio-form textarea")
        bio_form_text.value = bio_text.innerHTML.trim();
    }
}

function setFormHidden(bio, bio_form){
    if (bio_form.classList.contains("d-flex")) {
        bio_form.classList.remove("d-flex");
        bio_form.classList.add("d-none");
    }
    if (bio.classList.contains("d-none")) {
        bio.classList.remove("d-none");
        bio.classList.add("d-flex");
    }
}
