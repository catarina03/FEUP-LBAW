let edit_comment_buttons = document.getElementsByClassName("edit_comment_button");
addEditListeners();
function addEditListeners(){
    for(let i = 0;i<edit_comment_buttons.length;i++){
        let element = edit_comment_buttons[i];
        let container;
        let aux = element.parentNode.parentNode.parentNode.getElementsByClassName("comment_id")[0];
        let comment_id = aux.innerText;
        let type = null;
        if(aux.classList.contains("COMMENTID")){
            container = element.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
            type = "comment";
        }
        else if(aux.classList.contains("THREADID")){
            container = element.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
            type="thread";
        }
        element.addEventListener("click",function(e){
        e.preventDefault();
        editForm(comment_id,container,type);
        });
    }
}

function escapeHtml(unsafe) {
    return unsafe
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, "&#039;");
 }


function editForm(comment_id,content_container,type){
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    var request = new XMLHttpRequest();
    console.log(getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id + "/edit");
    request.open('get', getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id +"/edit", true);
    request.onload = function (){
        result = "";
        if(request.responseText != ""){
            comment_info = JSON.parse(request.responseText);
            console.log(comment_info);
            if(type!=null){
                let content = content_container.getElementsByClassName("comment_content")[0].innerText;
                content_container.getElementsByClassName("comment_content_container")[0].innerHTML = `<textarea class="container form-control post-page-add-comment w-100 edit-comment-form" style="width:100%;" id="edit-comment" rows="2" placeholder=" ${content}">${content}</textarea><div class="row justify-content-end confirm_edit_button px-0 mx-0">
                <div class="col-auto px-0">
                    <button class="post-page-comment-button btn mt-1  edit_comment_confirm pb-0">Save</button>
                </div>
            </div>`;
                var div = document.createElement('div');
                div.innerHTML = `<div class="row justify-content-end confirm_edit_button px-0 mx-0">
                        <div class="col-auto px-0">
                            <button class="post-page-comment-button btn mt-1 edit_comment_confirm justify-content-center">Save</button>
                        </div>
                    </div>`;
                let child = div.firstChild;
                //content_container.getElementsByClassName("comment_box")[0].appendChild(child,content_container.getElementsByClassName("comment_thread_section")[0]);
                displayEditElements(content_container,true);
            }
        let button = content_container.getElementsByClassName("edit_comment_confirm")[0];
    
        button.addEventListener("click",function (e){
            e.preventDefault();
            confirmEdit(comment_id,content_container,type);
        });
        }
        else{
            alert("Something went wrong!");
            return;
        }
        
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
}

function confirmEdit(comment_id,container,type){
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    var request = new XMLHttpRequest();
    let content = container.getElementsByClassName("edit-comment-form")[0].value;
    let route =  getUrl .protocol + "//" + getUrl.host + "/user/" + userID.innerText;
    console.log(getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id + "/edit");
    request.open('put', getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id +"/edit", true);
    request.onload = function (){
        if(request.status==200){
            let comment = JSON.parse(request.responseText);
            let result = "";
            if(!comment['isThread']){
                var div = document.createElement('div');
                div.innerHTML = comment["comment_view"];
                let child = div.firstChild;
                container.parentNode.replaceChild(child,container);
                let new_elements = container.getElementsByClassName("delete_comment_button");
                for(let k = 0;k<new_elements.length;k++){
                    let temp = new_elements[k];
                    let comment_container = temp.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
                    let local_cid = temp.parentNode.parentNode.parentNode.getElementsByClassName("comment_id")[0];
                    temp.addEventListener("click",function(e){
                        e.preventDefault();
                        deleteComment(local_cid,comment_container);
                    });
                }
                addShowThreadListeners();
            }
            else{
                var div = document.createElement('div');
                div.innerHTML = comment["comment_view"];
                let child = div.firstChild;
                container.parentNode.replaceChild(child,container);
                let new_elements = container.getElementsByClassName("delete_comment_button");
                for(let k = 0;k<new_elements.length;k++){
                    let temp = new_elements[k];
                    let comment_container = temp.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
                    let local_cid = temp.parentNode.parentNode.parentNode.getElementsByClassName("comment_id")[0];
                    temp.addEventListener("click",function(e){
                        e.preventDefault();
                        deleteComment(local_cid,comment_container);
                    });
                }
            }
        
        addDeleteCommentListeners();
        addListeners();
        addEditListeners();
        show_toaster("Comment edited sucessfully!");
        }
        else{
            empty_warning.show();
            return;
        }
    };
        
        
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send(encodeForAjax({'content':content}));

}
