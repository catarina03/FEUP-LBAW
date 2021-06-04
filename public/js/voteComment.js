let comments = document.querySelectorAll('.comment-container')
let thread_comments = document.querySelectorAll('.thread-container')

if(comments != null) comments.forEach((comment) => addCommentsEventListeners(comment))
if(thread_comments != null) thread_comments.forEach((comment) => addCommentsEventListeners(comment))


function addCommentsEventListeners(comment){
    let owner_id= comment.getElementsByClassName("owner_id")[0].innerText;
    let user_id = document.getElementById("user_ID").innerText;
    let upVoteComment = comment.querySelector('.post-page-comment-thumbs-up-button')
    let downVoteComment = comment.querySelector('.post-page-comment-thumbs-down-button')
    if((owner_id != user_id) && user_id!="0"){
        if(upVoteComment != null) upVoteComment.addEventListener('click', handleUpVoteComment.bind(comment))
        if(downVoteComment != null) downVoteComment.addEventListener('click',handleDownVoteComment.bind(comment))
    }
    else{
        if(upVoteComment != null) upVoteComment.addEventListener('click', function(){show_toaster("You cannot vote on your own comment!")});
        if(downVoteComment != null) downVoteComment.addEventListener('click', function(){show_toaster("You cannot vote on your own comment!")})
    }
}

function handleUpVoteComment(){
    const id = this.querySelector('.comment_id').innerHTML
    let downVoteComment = this.querySelector('.post-page-comment-thumbs-down-button')
    let upVotesCountComment = this.querySelector('.post-page-comment-interactions .up')
    let downVotesCountComment = this.querySelector('.post-page-comment-interactions .down')
    let icon = this.querySelector('i.fa-thumbs-up')
    if(icon.classList.contains('far')){
        icon.classList.remove('far')
        icon.classList.add('fas')
        let down = downVoteComment.querySelector('i.fa-thumbs-down')
        if(down.classList.contains('fas')){
            down.classList.remove('fas')
            down.classList.add('far')
            makeRequest("PUT", '/api/comment/'+ id +'/vote', handleVoteCommentResponse, encodeForAjax({vote: true}))
            downVotesCountComment.innerHTML = parseInt(downVotesCountComment.innerHTML) - 1
        }
        else makeRequest("POST", '/api/comment/'+ id +'/vote', handleVoteCommentResponse, encodeForAjax({vote: true}))
        upVotesCountComment.innerHTML = parseInt(upVotesCountComment.innerHTML) + 1
    }
    else if(icon.classList.contains('fas')){
        icon.classList.remove('fas')
        icon.classList.add('far')
        makeRequest("DELETE", '/api/comment/'+ id +'/vote', handleVoteCommentResponse, null)
        upVotesCountComment.innerHTML = parseInt(upVotesCountComment.innerHTML) - 1
    }
}

function handleDownVoteComment(){
    const id = this.querySelector('.comment_id').innerHTML
    let upVotesCountComment = this.querySelector('.post-page-comment-interactions .up')
    let downVotesCountComment = this.querySelector('.post-page-comment-interactions .down')
    let upVoteComment = this.querySelector('.post-page-comment-thumbs-up-button')

    let icon = this.querySelector('i.fa-thumbs-down')
    if(icon.classList.contains('far')){
        icon.classList.remove('far')
        icon.classList.add('fas')

        let up = upVoteComment.querySelector('i')
        if(up.classList.contains('fas')){
            up.classList.remove('fas')
            up.classList.add('far')
            makeRequest("PUT", '/api/comment/'+ id +'/vote', handleVoteCommentResponse, encodeForAjax({vote: false}))
            upVotesCountComment.innerHTML = parseInt(upVotesCountComment.innerHTML) - 1
        }
        else makeRequest("POST", '/api/comment/'+ id +'/vote', handleVoteCommentResponse, encodeForAjax({vote: false}))
        downVotesCountComment.innerHTML = parseInt(downVotesCountComment.innerHTML) + 1
    }
    else if(icon.classList.contains('fas')){
        icon.classList.remove('fas')
        icon.classList.add('far')
        makeRequest("DELETE", '/api/comment/'+ id +'/vote', handleVoteCommentResponse, null)
        downVotesCountComment.innerHTML = parseInt(downVotesCountComment.innerHTML) - 1
    }
}

function handleVoteCommentResponse(status, responseText){
    if(status === 200) console.log(responseText)
    else show_generic_warning("Error in vote comment: " + responseText)
}


