$('#select2-tags').select2({
    allowClear: true,
    placeholder: "You're not following any tags, click on the star in the post tags to follow them",
    theme: 'classic',
    tags: false,
    tokenSeparators: [',', ' '],

    width: '100%'
})

let cancel_social = document.querySelector('.cancel-button.social')
let cancel_password = document.querySelector('.cancel-button.password')
let cancel_personal = document.querySelector('.cancel-button.personal')
let cancel_preferences = document.querySelector('.cancel-button.preferences')

const name = document.querySelector('.settings #name').value
const username = document.querySelector('.settings #username').value
const email = document.querySelector('.settings #email').value
let twitter = document.querySelector('.settings #twitter').value
let facebook = document.querySelector('.settings #facebook').value
let instagram = document.querySelector('.settings #instagram').value
let linkedin = document.querySelector('.settings #linkedin').value
let peopleFollow = document.querySelector('.settings #flexSwitchCheckDefaultPeopleFollow').checked
let tagsFollow = document.querySelector('.settings #flexSwitchCheckDefaultTagsFollow').checked

let confirm = document.getElementById("confirm");
let yes = confirm.getElementsByClassName("col-2 btn custom-button")[0];


if(cancel_social != null){
    cancel_social.addEventListener('click', function(e){
        e.preventDefault()
        document.querySelector('#twitter').value = twitter
        document.querySelector('#facebook').value = facebook
        document.querySelector('#instagram').value = instagram
        document.querySelector('#linkedin').value = linkedin
    })
}
if(cancel_password != null){
    cancel_password.addEventListener('click', function(e){
        e.preventDefault()
        document.querySelector('#currentPassword').value = ""
        document.querySelector('#newPassword').value = ""
        document.querySelector('#confirmPassword').value = ""
    })
}

if(cancel_personal != null){
    cancel_personal.addEventListener('click', function(e){
        e.preventDefault()
        document.querySelector('.settings #name').value = name
        document.querySelector('.settings #username').value = username
        document.querySelector('.settings #email').value = email
    })
}

if(cancel_preferences != null){
    cancel_preferences.addEventListener('click', function(e){
        e.preventDefault()
        document.querySelector('.settings #flexSwitchCheckDefaultPeopleFollow').checked = peopleFollow
        document.querySelector('.settings #flexSwitchCheckDefaultTagsFollow').checked = tagsFollow
    })
}

function getUserID(){
    const args = window.location.pathname.split('/')
    return args[2]
}

if(yes != null) {
    yes.addEventListener("click", (e) => {
        e.preventDefault()
        makeRequest("DELETE", window.location.protocol + "//" + window.location.host + '/user/' + getUserID(), handleDeleteResponse, null)
    })
}

function handleDeleteResponse(status, responseText){
    if(status === 200){
        window.location = (window.location.protocol + "//" + window.location.host + JSON.parse(responseText))
    }
    else{
        const errorDelete = document.querySelector('.error-delete')
        if(errorDelete.classList.contains('d-none')){
            errorDelete.classList.remove('d-none')
            errorDelete.classList.add('d-flex')
        }
    }
}
