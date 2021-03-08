let change_password = document.querySelector('.settings .change-password')
let tags = document.querySelectorAll('.settings .tags a')

change_password.addEventListener('click', function(){
    let change_password_form = document.querySelector('.settings .change-password-form')
    if(change_password_form.classList.contains('d-none')){
        change_password_form.classList.remove('d-none')
        change_password_form.classList.add('d-flex')
    }
    else if(change_password_form.classList.contains('d-flex')){
        change_password_form.classList.remove('d-flex')
        change_password_form.classList.add('d-none')
    } 
})

tags.forEach(item =>
    item.addEventListener('click', function(){
        item.remove()
        let tags = document.querySelectorAll('.settings .tags a')
        if(tags.length == 0){
            let tag = document.querySelector('.settings .tags')
            let text = document.createElement('p')
            text.innerText = "You don't follow any tags"
            tag.append(text)
        }
    }))