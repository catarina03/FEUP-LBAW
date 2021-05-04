let x = document.getElementsByClassName("add_thread_button");
if(x!=null){
    for(let i = 0;i<x.length;i++){
            element = x[i];
            let parent = element.parentNode;
            let comment_id = parent.getElementsByClassName("thread_comment_id")[0].innerText;
            let content = parent.parentNode.parentNode.getElementsByClassName("row px-0 mx-0")[0].
            getElementsByClassName("d-flex mx-0 px-0")[0].getElementsByClassName("add-thread")[0];
            element.addEventListener("click",function(e){
                e.preventDefault();
                addThread(comment_id,content);
            });
    }        
        
    
}
function addThread(comment_id,content){
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    var request = new XMLHttpRequest();
    console.log(getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id +"/add_comment");
    request.open('post', getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id +"/add_comment", true);
    request.onload = function (){
        result = "";
        if(request.responseText==""){
            alert("Error adding comment");
            return;
        }
        document.getElementById("comment-section").innerHTML = request.responseText;
        content.value = "";
        
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send(encodeForAjax({content:content.value,comment_id:comment_id,user_id:userID.innerText}));
}