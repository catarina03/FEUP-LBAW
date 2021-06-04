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
            makeRequest("PUT", '/api/post/'+ getPostID() +'/vote',handleVoteResponse, encodeForAjax({vote: true}))
            downVotesCount.innerHTML = parseInt(downVotesCount.innerHTML) - 1
        }
        else makeRequest("POST", '/api/post/'+ getPostID() +'/vote',handleVoteResponse, encodeForAjax({vote: true}))
        upVotesCount.innerHTML = parseInt(upVotesCount.innerHTML) + 1
    }
    else if(icon.classList.contains('fas')){
        icon.classList.remove('fas')
        icon.classList.add('far')
        makeRequest("DELETE", '/api/post/'+ getPostID() +'/vote',handleVoteResponse, null)
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
            makeRequest("PUT", '/api/post/'+ getPostID() +'/vote',handleVoteResponse, encodeForAjax({vote:false}))
            upVotesCount.innerHTML = parseInt(upVotesCount.innerHTML) - 1
        }
        else makeRequest("POST", '/api/post/'+ getPostID() +'/vote',handleVoteResponse, encodeForAjax({vote:false}))
        downVotesCount.innerHTML = parseInt(downVotesCount.innerHTML) + 1
    }
    else if(icon.classList.contains('fas')){
        icon.classList.remove('fas')
        icon.classList.add('far')
        makeRequest("DELETE", '/api/post/'+ getPostID() +'/vote',handleVoteResponse, null)
        downVotesCount.innerHTML = parseInt(downVotesCount.innerHTML) - 1
    }
}


function handleVoteResponse(status, responseText){
    if(status === 200) console.log(responseText)
    else show_generic_warning("Error in vote: " + responseText)
}

function getPostID(){
    const path = window.location.pathname
    const pages = path.split('/')
    return pages[2]
}
