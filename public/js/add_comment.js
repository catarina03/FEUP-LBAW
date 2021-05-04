let add = document.getElementById("add_comment_button");
let content = document.getElementsByClassName("add-comment")[0];


if(add!=null){
    add.addEventListener("click",function (e){
        e.preventDefault();
        addComment();

    });
}

function addComment(){
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    console.log( getUrl .protocol + "//" + getUrl.host + "/" + "api/post/" + id.innerText + "/add_comment");
    request.open('post', getUrl .protocol + "//" + getUrl.host + "/" + "api/post/" + id.innerText + "/add_comment", true);
    request.onload = function (){
        result = "";
        if(request.responseText==""){
            alert("Error adding comment");
            return;
        }
        document.getElementById("comment-section").innerHTML = request.responseText;
        content.value = "";
        addListeners();
        
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    if(content.value=="" || content.value.match("^\\s+$")){
        alert("Empty comments are not allowed!");
        return;
    }
    request.send(encodeForAjax({content:content.value,post_id:id.innerText,user_id:userID.innerText}));
}