addSortListeners();
function addSortListeners(){
    let popular = document.getElementById("sort_popular");
    let newest = document.getElementById("sort_newest");
    let oldest = document.getElementById("sort_oldest");
    let comment_section = document.getElementById("comment-section");
    popular.addEventListener("click",function(e){
        e.preventDefault();
        sortComments("popular_comments",comment_section);
        updateSortedBy("Popular");
        
    });

    newest.addEventListener("click",function(e){
        e.preventDefault();
        sortComments("newer_comments",comment_section);
        updateSortedBy("Newer");
    });

    oldest.addEventListener("click",function(e){
        e.preventDefault();
        sortComments("older_comments",comment_section);
        updateSortedBy("Older");
    });
}


function sortComments(sort_by,comment_section){
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    request.open('get', getUrl .protocol + "//" + getUrl.host + "/" + "api/post/" + id.innerText + "/" + sort_by, true);
    request.onload = function (){
        result = "";
        if(request.responseText==""){
            alert("Error sorting comments!");
            return;
        }
        comment_section.innerHTML = request.responseText;
        addListeners();
        addDeleteCommentListeners();
        addEditListeners();
        addShowThreadListeners();
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
}