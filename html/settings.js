let change_password = document.querySelector('.settings .change-password')

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