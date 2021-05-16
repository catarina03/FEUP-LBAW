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
        let temp = request.responseText;
        temp+=document.getElementById("comment-section").innerHTML;
        document.getElementById("comment-section").innerHTML = temp;
        let new_comments = document.getElementById("comment-section").getElementsByClassName("COMMENTID");
        let seen = [];
        for(let i =0;i<new_comments.length;i++){
            let actual = new_comments[i];
            if(seen.includes(actual.innerText)){
                console.log("REMOVED");
                actual.parentNode.parentNode.parentNode.parentNode.remove();
            }    
            else{
                
                seen.push(actual.innerText);
                continue;
            }
            console.log(seen);
        }
        content.value = "";
        addListeners();
        addDeleteCommentListeners();
        addEditListeners();
        fixCommentSettingsListeners();
        addShowThreadListeners();
        updateSortedBy("Sort by");
        updateCommentCount(1);
        
        
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    if(content.value=="" || content.value.match("^\\s+$")){
        alert("Empty comments are not allowed!");
        return;
    }
    request.send(encodeForAjax({content:content.value,post_id:id.innerText,user_id:userID.innerText}));
}