/* My profile*/

let pencil = document.querySelector(".my-profile .pencil-icon");
let save = document.querySelector(".my-profile .save-form");
let userId = document.querySelector("input.current-user-id")
/*
let photo = document.querySelector("img.rounded-circle.profile-avatar");
let user_id = document.querySelector("input.page-info.user_id");
 */

if (pencil != null) {
  pencil.addEventListener("click", function () {
    let bio = document.querySelector(".my-profile .bio");
    let bio_form = document.querySelector(".my-profile .bio-form");
    if (bio.classList.contains("d-flex")) {
      bio.classList.remove("d-flex");
      bio.classList.add("d-none");
    }

    if (bio_form.classList.contains("d-none")) {
      bio_form.classList.remove("d-none");
      bio_form.classList.add("d-flex");

      //Default value
      let bio_text = document.querySelector(".my-profile .bio .bio-text")
      let bio_form_text = document.querySelector(".my-profile .bio-form textarea")
      bio_form_text.value = bio_text.innerHTML.trim();
    }
  });
}

if (save != null) {
    save.addEventListener("click", function (e) {
        e.preventDefault();
        var getUrl = window.location;
        let bio_text = document.querySelector("textarea.form-control");
        console.log("api/user/"+userId.value+"/edit_bio")
        makeRequest("put", getUrl.protocol + "//" + getUrl.host  + "/api/user/"+userId.value+"/edit_bio", update_bio, bio_text.value)
    });
}

function update_bio(status, requestStatus, response){
    let bio = document.querySelector(".my-profile .bio");
    let bio_form = document.querySelector(".my-profile .bio-form");
    if (bio_form.classList.contains("d-flex")) {
        bio_form.classList.remove("d-flex");
        bio_form.classList.add("d-none");
    }
    if (bio.classList.contains("d-none")) {
        bio.classList.remove("d-none");
        bio.classList.add("d-flex");
    }
    let bioContent = JSON.parse(response)


    let oldBioPartial = document.querySelector('div.profile-bio-div');
    oldBioPartial.replaceWith(   bioContent['profilebio']);
   // bio.value =
    //Add event listeners
}

/*
if(photo != null){
    photo.addEventListener("submit", function(e){
        e.preventDefault()
        makeRequest(user_id, photo.value)

    });
}

function makeRequest(id, photo){
    const photoRequest = new XMLHttpRequest()
    photoRequest.onreadystatechange = function(){
        if(photoRequest.readyState === XMLHttpRequest.DONE){
            console.log("DONE")
            if(photoRequest.status === 200){
                let photoResponse = photoRequest.responseText
                console.log(photoRequest)
                console.log(photoResponse)
                updateProfilePhoto(photoResponse)
                //displaySpinner(true, type)
            }
            else alert('Error fetching api: ' +  photoRequest.status)
        }
    }
    photoRequest.open('PUT',  'api/user/' + id + '/edit_photo', true)
    photoRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    photoRequest.send(JSON.stringify({
        profile_photo: photo
    }));
    console.log(photoRequest);
   // photoRequest.send()
}

function updateProfilePhoto(photoResponse){
    console.log("UPDATE")
    console.log(photo)
   /* let pag = document.querySelector('.homepage .pagination')
    if(pag != null)
        pag.parentNode.removeChild(pag)
    let postDiv = document.querySelector('.postsCards')
    let newDiv = document.createElement('div')
    postDiv.innerHTML = ""
    newDiv.innerHTML= posts
    while (newDiv.firstChild) {
        postDiv.appendChild(newDiv.firstChild)
    }
    addLoadMore(postDiv)

    */
/*
    photo.src = photoResponse;
}
 */
