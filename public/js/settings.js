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
//let tagsSelected = document.querySelectorAll('.select2-tags option')


if(cancel_social != null){
    cancel_social.addEventListener('click', function(e){
        e.preventDefault()
        document.querySelector('#twitter').value = twitter
        document.querySelector('#facebook').value = facebook
        document.querySelector('#instagram').value = instagram
        document.querySelector('#linkedin').value = linkedin
        console.log("cancel-social")
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


let confirm = document.getElementById("confirm");
let yes = confirm.getElementsByClassName("col-2 btn custom-button")[0];
let id = document.getElementById("post_ID");

if(yes != null){
    yes.addEventListener("click", function(){
        const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        const args = window.location.pathname.split('/')
        const userID = args[2]
        const request = new XMLHttpRequest()
        request.onreadystatechange = function(){
            if(request.readyState === XMLHttpRequest.DONE){
                if(request.status === 200){
                    window.location = (window.location.protocol + "//" + window.location.host + JSON.parse(request.responseText))
                }
                else{
                    const errorDelete = document.querySelector('.error-delete')
                    if(errorDelete.classList.contains('d-none')){
                        errorDelete.classList.remove('d-none')
                        errorDelete.classList.add('d-flex')
                    }
                }
            }
        }
        request.open('delete', window.location.protocol +"//" + window.location.host + '/user/'+ userID, true)
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        request.setRequestHeader("X-Requested-With", "XMLHttpRequest");
        request.setRequestHeader("X-CSRF-TOKEN", token);
        request.send()
    })
}
