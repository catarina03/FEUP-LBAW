let isFollowing = document.querySelector("input.is-following")
let followButton = document.querySelector("button.follow") || document.querySelector("button.unfollow")

if(parseInt(isFollowing.value) === 0){
    let followButton = document.querySelector("button.follow")
    followButton.addEventListener("click", followRequest);
} else {
    let followButton = document.querySelector("button.unfollow")
    followButton.addEventListener("click", unfollowRequest)
}

function followRequest(e){
    e.preventDefault();
    let getUrl = window.location;
    let user_id = document.querySelector("input.user-id-value")
    makeRequest("post", getUrl.protocol + "//" + getUrl.host  + '/api/user/' + user_id.value + '/follow', makeFollow, encodeForAjax({'id':user_id.value}))
}

function unfollowRequest(e){
    e.preventDefault();
    let getUrl = window.location;
    let user_id = document.querySelector("input.user-id-value")
    makeRequest("delete", getUrl.protocol + "//" + getUrl.host  + '/api/user/' + user_id.value + '/follow', makeUnfollow, encodeForAjax({'id':user_id.value}))
}

function makeFollow(status, response){
    if (status === 200){
        let number_followers = document.querySelector("div.number-followers p")
        number_followers.innerText = parseInt(number_followers.innerText.split(" ")[0])+1 + " Followers"
        followButton.classList.remove('follow')
        followButton.classList.add('unfollow')
        followButton.innerHTML = '<i class="fas fa-user-check"></i>  Following'
        followButton.removeEventListener("click", followRequest)
        followButton.addEventListener("click", unfollowRequest)
    } else if(status === 403){
        // window.location.href = 'newPage.html';

    }
    else {
        alert("Error fetching api: " + status)
    }
}

function makeUnfollow(status, response){
    if (status === 200){
        let number_followers = document.querySelector("div.number-followers p")
        number_followers.innerText = parseInt(number_followers.innerText.split(" ")[0])-1 + " Followers"
        followButton.classList.remove('unfollow')
        followButton.classList.add('follow')
        followButton.innerHTML = 'Follow'
        followButton.removeEventListener("click", unfollowRequest)
        followButton.addEventListener("click", followRequest)
    } else if(status === 403){
       // window.location.href = 'newPage.html';
    }
    else {
        alert("Error fetching api: " + status)
    }
}
