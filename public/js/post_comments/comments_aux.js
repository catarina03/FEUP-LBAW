function updateThreadsNo(ammount,comment_id){
    let container = document.getElementsByClassName("comment-container");
    for(let i =0;i<container.length;i++){
        let cur_id = container[i].getElementsByClassName("thread_comment_id")[0].innerText;
        console.log(cur_id + " " + comment_id);
        
        if(cur_id == comment_id){

            let thread_count = container[i].getElementsByClassName("post-page-comment-interactions")[2];
            console.log(thread_count.innerText);
            thread_count.innerHTML= parseInt(thread_count.innerText) + ammount + " <i class=\"far fa-comments\"></i>";
            return true;
        }

    }
    return false;
}

function updateSortedBy(text){
    let sorted = document.getElementsByClassName("comment-sort-by-button p-0 m-0")[0];
    sorted.innerText = text;
}