/* User profile */

let follow = document.querySelector('.userprofile .follow')
let block = document.querySelector('.userprofile .block')

follow.addEventListener('click', function(e){
    if(e.target.innerText == "Follow")
        e.target.innerText = "Following"
    else if(e.target.innerText == "Following")
        e.target.innerText = "Follow"
})

block.addEventListener('click', function(e){
    console.log()
    if(e.target.innerText == "Block")
        e.target.innerText = "Unblock"
    else if(e.target.innerText == "Unblock")
        e.target.innerText = "Block"
})