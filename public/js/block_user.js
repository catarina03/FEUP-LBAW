let isBlocked = document.querySelector("input.is-blocked")
let blockButton = document.querySelector(".userprofile button.block") || document.querySelector(".userprofile button.unblock")


if(parseInt(isBlocked.value) === 0){
    let blockButton = document.querySelector("button.block")
    if(blockButton != null){
        blockButton.addEventListener("click", (e)=>{
            e.stopPropagation()
            e.preventDefault()
            askRequest( true)
        });
    }
} else {
    let blockButton = document.querySelector("button.unblock")
    if(blockButton != null){
        blockButton.addEventListener("click", (e)=>{
            e.stopPropagation()
            e.preventDefault()
            askRequest(false)
        })
    }
}

function askRequest(isPost){
    let user_id = document.querySelector("input.user-id-value")
    if(isPost) makeRequest("post", '/api/user/' + user_id.value + '/block', blockRequest, encodeForAjax({'id':user_id.value}))
    else makeRequest("delete", '/api/user/' + user_id.value + '/block', unblockRequest, encodeForAjax({'id':user_id.value}))
}



function blockRequest(status, response){
    console.log(response)
    if (status === 200){
        updateButton(true)
    } else if(status === 403){
        // window.location.href = 'newPage.html';
    }
    else {
        alert("Error fetching api: " + status)
    }
}

function unblockRequest(status, response){
    console.log(response)
    if (status === 200){
        updateButton(false)
    } else if(status === 403){
        // window.location.href = 'newPage.html';
    }
    else {
        alert("Error fetching api: " + status)
    }
}

function updateButton(block){
    let number_followers = document.querySelector("div.number-followers p")
    number_followers.innerText = parseInt(number_followers.innerText.split(" ")[0])-1 + " Followers"
    if(block){
        blockButton.classList.remove('block')
        blockButton.classList.add('unblock')
        blockButton.innerHTML = 'Blocking'
    }
    else{
        blockButton.classList.remove('unblock')
        blockButton.classList.add('block')
        blockButton.innerHTML = 'Block'
    }
    blockButton.removeEventListener("click", askRequest)
    let a = blockButton.cloneNode(true)
    blockButton.parentNode.replaceChild(a, blockButton)
    blockButton = a
    blockButton.addEventListener("click", function(e){
        e.stopPropagation()
        e.preventDefault()
        askRequest(!block)
    })
}
