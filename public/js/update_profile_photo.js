let photo = document.querySelector("img.rounded-circle.profile-avatar").getAttribute('src');
let user_id = document.querySelector("input.page-info.user_id");
let form_photo = document.querySelector("input.form-control-file");
let token = document.getElementsByName("csrf-token")[0];

form_photo.addEventListener("change", preparePhotoRequest)

function preparePhotoRequest(){
    let formData = new FormData();
    formData.append('avatar', form_photo.files[0]);
    for (var key of formData.entries()) {
        console.log(key[0] + ', ' + key[1])
    }
    makePhotoRequest(user_id.value, formData);
}



function makePhotoRequest(id, formData) {
    var getUrl = window.location;
    let photoRequest = new XMLHttpRequest()
   // console.log(getUrl.protocol + "//" + getUrl.host + "/api/user/" + id + "/edit_photo")
   // console.log(photoRequest.responseURL);
   // photoRequest.open('put', "api/user/" + id + "/edit_photo", true);
   // photoRequest.open('put', getUrl.protocol + "//" + getUrl.host + "/api/user/" + id + "/edit_photo", true);
    photoRequest.open('post', getUrl.protocol + "//" + getUrl.host + "/api/user/" + id + "/edit_photo", true);
    //console.log(getUrl.protocol + "//" + getUrl.host + "/api/user/" + id + "/edit_photo")
    photoRequest.setRequestHeader('X-CSRF-TOKEN', token.getAttribute("content"));
   // photoRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

    //photoRequest.setRequestHeader("Content-Type", "x-www-form-urlencoded");

   // console.log(photoRequest.responseURL);
    photoRequest.onreadystatechange = function () {
        if (photoRequest.readyState === XMLHttpRequest.DONE) {
            console.log(photoRequest.responseText);
            if (photoRequest.status === 200) {
                //window.alert("HERE2")
               const response = JSON.parse(photoRequest.responseText);
               // const response = photoRequest.responseText;
                console.log(response)
                updateProfilePhoto(response['profilephoto'])
                //displaySpinner(true, type)
            } else if(photoRequest.status === 415){
                alert(photoRequest.responseText)
            } else if(photoRequest.status === 500){
                alert(photoRequest.responseText)
            } else alert('Error fetching api: ' + photoRequest.status)

        }
    }
    //photoRequest.open('PUT', '/api/user/' + id + '/edit_photo', true)
    /*
    console.log(photoRequest.responseURL);
//    photoRequest.setRequestHeader('X-CSRF-TOKEN', token.getAttribute("content"));
    console.log(photoRequest.responseURL);
    //photoRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    photoRequest.setRequestHeader('Content-type', 'multipart/form-data');
    console.log(photoRequest.responseURL);
    photoRequest.send(JSON.stringify({
        avatar: photo
    }));
    console.log(photoRequest.responseURL);
    */
    for (var key of formData.entries()) {
        console.log(key[0] + ', ' + key[1])
    }
    photoRequest.send(formData);
   // photoRequest.send(encodeForAjax({'avatar':formData.get('avatar')}));
   // photoRequest.send(encodeForAjax({'avatar':  form_photo.files[0]}));
    //photoRequest.send(form_photo.files[0]);


   // photoRequest.send(encodeForAjax({'form':formData}));
}





function updateProfilePhoto(photoResponse) {
    let photoDiv = document.querySelector('.profile-photo-div')
    photoDiv.innerHTML = ""
    photoDiv.innerHTML = photoResponse

    form_photo = document.querySelector("input.form-control-file");
    form_photo.addEventListener("change", preparePhotoRequest)
}
