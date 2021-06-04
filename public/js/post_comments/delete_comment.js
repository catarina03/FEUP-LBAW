addDeleteCommentListeners();
function addDeleteCommentListeners(){
    let x = document.getElementsByClassName("delete_comment_button");
    if(x!=null){
        for(let i = 0;i<x.length;i++){
                let element = x[i];
                let elementClone = element.cloneNode(true);
                element.parentNode.replaceChild(elementClone,element);
                let parent = elementClone.parentNode;
                let container = parent.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
                let comment_id = parent.parentNode.parentNode.getElementsByClassName("comment_id")[0];
                elementClone.addEventListener("click",function(e){
                    e.preventDefault();
                    deleteComment(comment_id,container);
                });
        }        
    }
}


function deleteComment(comment_id,container){
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    var request = new XMLHttpRequest();
    request.open('delete', getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id.innerText, true);
    request.onload = function (){
        result = "";
        if(request.responseText == "SUCCESS"){
            container.remove();
            if(comment_id.classList.contains("THREADID")){
                let l = comment_id.parentNode.getElementsByClassName("parent_id")[0];
                updateThreadsNo(-1,l.innerText);
                

            }else{
                updateCommentCount(-1);
            }
            show_toaster("Comment deleted succesfully!")
        }
        else{
            show_generic_warning("Internal error when trying to delete this comment!");
            return;
        }
        
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
}