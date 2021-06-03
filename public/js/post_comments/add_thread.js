let userID = document.getElementById("user_ID");
addListeners();
function addListeners(){
    let x = document.getElementsByClassName("add_thread_button");
    if(x!=null){
        for(let i = 0;i<x.length;i++){
                let element = x[i];
                let elementClone = element.cloneNode(true);
                element.parentNode.replaceChild(elementClone,element);
                let parent = elementClone.parentNode;
                let comment_id = parent.getElementsByClassName("thread_comment_id")[0].innerText;
                let content = parent.parentNode.parentNode.getElementsByClassName("reply_textarea_container")[0].
                getElementsByClassName("reply_textarea")[0].getElementsByClassName("add-thread")[0];
                elementClone.addEventListener("click",function(e){
                    e.preventDefault();
                    addThread(comment_id,content);
                });
        }        
            
        
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
        if(request.status==400){
            alert("Error adding comment");
            return;
        }
        else if(request.status==200){
            let containers = document.getElementsByClassName("comment-container");
            //let tempK = request.responseText;
            for(let i = 0;i<containers.length;i++){
                let temp = containers[i];
                let text = temp.getElementsByClassName("COMMENTID")[0].innerText;
                if(text)
                    if(text == comment_id){
                        let temp_threads = request.responseText;
                        let cont = containers[i].getElementsByClassName("comment_thread_section")[0];
                        temp_threads += cont.innerHTML;
                        cont.innerHTML = temp_threads;
                        break;
                    }
            }
            //document.getElementById("comment-section").innerHTML = request.responseText;
            content.value = "";
            updateThreadsNo(1,comment_id);
            addListeners();
            addDeleteCommentListeners();
            addEditListeners();
            addReportListeners();
            openThreads(comment_id);
        }
        
    };
    if(content.value=="" || content.value.match("^\\s+$")){
        //alert("Empty comments are not allowed!");
        empty_warning.show();
        return;
    }
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send(encodeForAjax({content:content.value,comment_id:comment_id,user_id:userID.innerText}));
}