
loadMoreListener();
function loadMoreListener(){
    let button = document.getElementById("load_more");
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
            alert("Error sorting comments!");
            return;
        }
        

        currentPage+=1;
        comment_section.innerHTML += request.responseText;
        addListeners();
        addDeleteCommentListeners();
        addEditListeners();
        addShowThreadListeners();
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