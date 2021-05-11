let photo = document.querySelector("img.rounded-circle.profile-avatar").getAttribute('src');
let user_id = document.querySelector("input.page-info.user_id");
let form_photo = document.querySelector("input.form-control-file");
let token = document.getElementsByName("csrf-token")[0];

if(form_photo != null){
    form_photo.addEventListener("change", function (e){
        e.preventDefault();
        makeRequest(user_id.value, form_photo.value); //?
    })
}



/*
if(photo != null){
    photo.addEventListener("submit", function(e){
        e.preventDefault()
        makeRequest(user_id, photo.value)

    });
}

 */

function makeRequest(id, photo){
    const photoRequest = new XMLHttpRequest()
    const getUrl = window.location;
    photoRequest.onreadystatechange = function(){
        if(photoRequest.readyState === XMLHttpRequest.DONE){
            console.log("DONE")
            if(photoRequest.status === 200){
                let photoResponse = photoRequest.responseText
                console.log("REQUEST")
                console.log(photoRequest)
                console.log(photoResponse)
                updateProfilePhoto(photoResponse)
                //displaySpinner(true, type)
            }
            else alert('Error fetching api: ' +  photoRequest.status)
        }
    }
    console.log(getUrl .protocol + '//' + getUrl.host + '/' + 'api/user/' + id + '/edit_photo');
    console.log(photo)
   // photoRequest.open('post', getUrl .protocol + "//" + getUrl.host + "/" + "api/post/" + id.innerText + "/add_comment", true);
    photoRequest.open('PUT',  getUrl .protocol + '//' + getUrl.host + '/' + 'api/user/' + id + '/edit_photo', true)
    photoRequest.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    photoRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    photoRequest.send(JSON.stringify({
        avatar: photo
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
    photo.src = photoResponse;
}
