function updateThreadsNo(ammount,comment_id){
    let container = document.getElementsByClassName("comment-container");
    for(let i =0;i<container.length;i++){
        let cur_id = container[i].getElementsByClassName("thread_comment_id")[0].innerText;
        if(cur_id == comment_id){
            let thread_count = container[i].getElementsByClassName("post-page-comment-interactions")[2];
            thread_count.innerHTML= parseInt(thread_count.innerText) + ammount + " <i class=\"far fa-comments\"></i>";
            return true;
        }

    }
    return false;
}

function updateCommentCount(amount){
    let container = document.getElementById("post_comment_count");
    container.parentNode.innerHTML= `<h3 class="post-page-post-interactions" id="post_comment_count">` + (parseInt(container.innerText) + amount) + " <i class=\"far fa-comments\"></i></h3>";
    if(parseInt(container.innerText) + amount == 0){
        LoadMoreVisibility(true);
        EmptyCommentsVisibility(false);
    }    
        return true;
}

function openThreads(comment_id){
    let container = document.getElementsByClassName("comment-container");
    for(let i =0;i<container.length;i++){
        let cur_id = container[i].getElementsByClassName("thread_comment_id")[0].innerText;
        
        if(cur_id == comment_id){
            container[i].getElementsByClassName("thread-reply")[0].removeAttribute("hidden");

            let sections = container[i].getElementsByClassName("thread-section");
            for(let k = 0;k<sections.length;k++){
                sections[k].removeAttribute("hidden");
            }
            return true;
        }
    }
    return false;
}


function LoadMoreVisibility(isV){
    let j = document.getElementById("load_more");
    if(j!=null){
        if(isV)
            j.setAttribute("hidden",isV);
        else
            j.removeAttribute("hidden");
    }
}

function EmptyCommentsVisibility(isV){
    let j = document.getElementById("empty-comments");
    if(j){
    if(isV)
        j.setAttribute("hidden","");
    else
        j.removeAttribute("hidden");

    }
}

function displayEditElements(container,hide){
    let drop = container.getElementsByClassName("dropdown")[0];
    if(drop){
        if(hide){
            drop.classList.add("d-none");
        }
        else{
            drop.classList.remove("d-none");
        }
    }
    let name = container.getElementsByClassName("post-page-comment-author-date")[0];
    if(!name)
        name = container.getElementsByClassName("post-page-comment-reply-author-date")[0];
    if(name){
        if(hide){
            name.classList.add("d-none");
        }
        else{
            name.classList.remove("d-none");
        }
    }
    let int = container.getElementsByClassName("comment_interactions")[0];
    if(int){
        if(hide){
            int.classList.add("d-none");
        }
        else{
            int.classList.remove("d-none");
        }
    }

}

function remove_error_messages(){
    let errors = document.getElementsByClassName("comment_error_message");
    if(errors && errors.length>0){
        for(let i=0;i<errors.length;i++){
            errors[i].remove();
        }
    }
}

function addCommentError(target){
    var div = document.createElement('div');
    div.innerHTML =("<span class=\"comment_error_message text-danger\">Empty comments and lengths greater than 1000 are not accepted!</span>").trim();
    errorNode = div.firstChild;
    target.parentNode.parentNode.insertBefore(errorNode,target.parentNode.nextSibling);


}