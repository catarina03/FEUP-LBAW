let upVote = document.querySelector('.post-up-vote')
let downVote = document.querySelector('.post-down-vote')
let upVotesCount = document.querySelector('.post-page-post-interactions .up')
let downVotesCount = document.querySelector('.post-page-post-interactions .down')
if(upVote != null) upVote.addEventListener('click', (e) => handleUpVote(e))


if(downVote != null) downVote.addEventListener('click', (e) => handleDownVote(e))

function handleUpVote(e){
    e.preventDefault()
    let icon = upVote.querySelector('i')
    if(icon.classList.contains('far')){
        icon.classList.remove('far')
        icon.classList.add('fas')
        let down = downVote.querySelector('i')
        if(down.classList.contains('fas')){
            down.classList.remove('fas')
            down.classList.add('far')
            makeRequest("PUT", true)
            downVotesCount.innerHTML = parseInt(downVotesCount.innerHTML) - 1
        }
        else makeRequest("POST", true)
        upVotesCount.innerHTML = parseInt(upVotesCount.innerHTML) + 1
    }
    else if(icon.classList.contains('fas')){
        icon.classList.remove('fas')
        icon.classList.add('far')
        makeRequest("DELETE", null)
        upVotesCount.innerHTML = parseInt(upVotesCount.innerHTML) - 1
    }
}

function handleDownVote(e){
    e.preventDefault()
    let icon = downVote.querySelector('i')
    if(icon.classList.contains('far')){
        icon.classList.remove('far')
        icon.classList.add('fas')
        let up = upVote.querySelector('i')
        if(up.classList.contains('fas')){
            up.classList.remove('fas')
            up.classList.add('far')
            makeRequest("PUT", false)
            upVotesCount.innerHTML = parseInt(upVotesCount.innerHTML) - 1
        }
        else makeRequest("POST", false)
        downVotesCount.innerHTML = parseInt(downVotesCount.innerHTML) + 1
    }
    else if(icon.classList.contains('fas')){
        icon.classList.remove('fas')
        icon.classList.add('far')
        makeRequest("DELETE", null)
        downVotesCount.innerHTML = parseInt(downVotesCount.innerHTML) - 1
    }
}

function makeRequest(type, vote){
    const post_id = getPostID()
    const voteRequest = new XMLHttpRequest()
    voteRequest.onreadystatechange = function(){
        if(voteRequest.readyState === XMLHttpRequest.DONE){
            if(voteRequest.status === 200){
                console.log(voteRequest.responseText)
            }
            else alert('Error in vote: ' +  voteRequest.response)
        }
    }
    let token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    if(type === "DELETE")
        voteRequest.open(type, window.location.protocol +"//" + window.location.host + '/api/post/'+ post_id +'/vote', true)
    else voteRequest.open(type, window.location.protocol +"//" + window.location.host + '/api/post/'+ post_id +'/vote', true)
    voteRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    voteRequest.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    voteRequest.setRequestHeader("X-CSRF-TOKEN", token);
    if(type === "DELETE") voteRequest.send()
    else voteRequest.send(encodeForAjax({vote: vote}));
}

function getPostID(){
    let path = window.location.pathname
    const pages = path.split('/')
    return pages[2]
}
