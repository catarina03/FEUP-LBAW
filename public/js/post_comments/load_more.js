
loadMoreListener();
function loadMoreListener(){
    let button = document.getElementById("load_more");
    if(button!=null)
        button.addEventListener("click",function(e){
            e.preventDefault();
            loadMore();
        });
}

function loadMore(){
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    let comment_section = document.getElementById("comment-section");
    console.log( getUrl .protocol + "//" + getUrl.host + "/" + "api/post/" + id.innerText + "/load_more/" + (currentPage+1));
    request.open('get', getUrl .protocol + "//" + getUrl.host + "/" + "api/post/" + id.innerText + "/load_more/" + (currentPage+1), true);
    request.onload = function (){
        result = "";
        if(request.responseText==""){
            show_generic_warning("Error fetching comments!");
            return;
        }
        

        currentPage+=1;
        comment_section.innerHTML = request.responseText;
        removeDup();
        addListeners();
        addDeleteCommentListeners();
        addEditListeners();
        addShowThreadListeners();
        addReportListeners();
        let comments = comment_section.querySelectorAll('.comment-container');
        if(comments != null) comments.forEach((comment) => addCommentsEventListeners(comment));
        let threads = comment_section.querySelectorAll('.thread-container');
        if(comments != null) threads.forEach((comment) => addCommentsEventListeners(comment));
        let qt =document.getElementsByClassName("COMMENTID");
        if(qt.length >= parseInt(document.getElementById("post_comment_count").innerText)){
            let button = document.getElementById("load_more");
            button.setAttribute("hidden",true);
        }
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
}
/*
let teste = document.getElementsByClassName("XD");
for(let i =0;i<teste.length;i++){
    teste[i].addEventListener("click",function(e){
        e.stopPropagation();
        console.log("CARAI");
    })
}*/

function removeDup(){
    let new_comments = document.getElementsByClassName("COMMENTID");
        let seen = [];
        console.log(new_comments.length);
        for(let i =0;i<new_comments.length;i++){
            let actual = new_comments[i];
            console.log(":" + actual.innerText + ":");
            if(seen.includes(actual.innerText)){
                //console.log("REMOVED");
                actual.parentNode.parentNode.parentNode.parentNode.remove();
            }    
            else{
                
                seen.push(actual.innerText);
            }
            
        }
}