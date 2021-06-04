let photo = document.querySelector("img.rounded-circle.profile-avatar").getAttribute('src');
let user_id = document.querySelector("input.page-info.user_id");
let form_photo = document.querySelector("input.form-control-file");
let token = document.getElementsByName("csrf-token")[0];

console.log(document.querySelector('img.profile-avatar'))

if (form_photo != null){
    form_photo.addEventListener("change", preparePhotoRequest)
}

function preparePhotoRequest(){
    let formData = new FormData();
    formData.append('avatar', form_photo.files[0]);
    makePhotoRequest(user_id.value, formData);
}

function makePhotoRequest(id, formData) {
    var getUrl = window.location;
    let photoRequest = new XMLHttpRequest()
    photoRequest.open('post', getUrl.protocol + "//" + getUrl.host + "/api/user/" + id + "/edit_photo", true);
    photoRequest.setRequestHeader('X-CSRF-TOKEN', token.getAttribute("content"));
    photoRequest.onreadystatechange = function () {
        if (photoRequest.readyState === XMLHttpRequest.DONE) {
            if (photoRequest.status === 200) {
               const response = JSON.parse(photoRequest.responseText);
                updateProfilePhoto(response['profilephoto'])
            } else if(photoRequest.status === 415){
                alert(photoRequest.responseText)
            } else if(photoRequest.status === 500){
                alert(photoRequest.responseText)
            } else alert('Error fetching api: ' + photoRequest.status)
        }
    }
    photoRequest.send(formData);
}

function updateProfilePhoto(photoResponse) {
    let photoDiv = document.querySelector('.profile-photo-div')
    photoDiv.innerHTML = photoResponse
    form_photo = document.querySelector("input.form-control-file");
    form_photo.addEventListener("change", preparePhotoRequest)
}
