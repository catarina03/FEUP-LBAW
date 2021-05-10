let edit_comment_buttons = document.getElementsByClassName("edit_comment_button");
addEditListeners();
function addEditListeners(){
    for(let i = 0;i<edit_comment_buttons.length;i++){
        let element = edit_comment_buttons[i];
        let comment_id = element.parentNode.parentNode.parentNode.getElementsByClassName("comment_id")[0].innerText;
        let container = element.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
        element.addEventListener("click",function(e){
            e.preventDefault();
            editForm(comment_id,container);
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


function editForm(comment_id,content_container){
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
            content_container.innerHTML = `<div class="row justify-content-center px-4 mx-1">
            <div class="col-10 mx-0 px-0" style="border-radius:5px;">
                <div class="row m-0 p-0">
                    <div class="d-flex mx-0 px-0">
            
                        <textarea class="container form-control post-page-add-comment w-100 edit-comment-form" id="edit-comment" rows="2" placeholder=" ${comment_info['content']}">${comment_info['content']}</textarea>
                    </div>
                </div>
                <div class="row px-0 mx-0 justify-content-end">
                    <div class="col-auto px-0">
                        <button class="post-page-comment-button btn mt-1 mb-2 edit_comment_confirm">Save changes</button>
                    </div>
                </div>
            </div>
        </div>`;
        let button = content_container.getElementsByClassName("edit_comment_confirm")[0];
    
        button.addEventListener("click",function (e){
            e.preventDefault();
            confirmEdit(comment_id,content_container);
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

function confirmEdit(comment_id,container){
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    var request = new XMLHttpRequest();
    let content = container.getElementsByClassName("edit-comment-form")[0].value;
    let route =  getUrl .protocol + "//" + getUrl.host + "/user/" + userID.innerText;
    console.log(getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id + "/edit");
    request.open('put', getUrl .protocol + "//" + getUrl.host + "/api/" + "comment/"+comment_id +"/edit", true);
    request.onload = function (){
        if(request.responseText!=""){
            let comment = JSON.parse(request.responseText);
            let result = "";
            if(comment['comment']['post_id'] != null){
                result+=`<span class="comment-container">
                <div class="row justify-content-center px-4 mx-1">
                <div class="col-10 post-page-comment pt-3 pb-2 px-3 mt-2 show-hide-replies\" style="cursor:pointer">
                    <div class="row px-2 py-0">
                        <div class="col-auto p-0 m-0">
                            <h3 class="post-page-comment-body m-0">`+ escapeHtml(comment['comment']['content'])+ `</h3>
                        </div>    
                            <div class="col-auto p-0 m-0 ms-auto">
                                <span class="comment_id" hidden>` + escapeHtml(comment['comment']['id'].toString()) + `</span>` +
                                
                                (userID.innerText==comment['comment']['user_id']?
                                `<div class="dropdown">
                                    <a class="btn fa-cog-icon"  style="font-size:30%;" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-cog ms-auto" style="font-size:3em;"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <a class="dropdown-item edit_comment_button">Edit Comment</a>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <a class="dropdown-item delete_comment_button" >Delete Comment</a>
                                    </ul>
                                </div>`:``)

                                +

                            `</div>
                        </div>
                
                    <div class="row align-items-end px-2 py-1">
                        <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end">
                            <h3 class="post-page-comment-author-date p-0 m-0">by <a href="${route}">` + escapeHtml(comment['author']) + `</a>, ` +  escapeHtml(comment['date']) + `</h3>
                        </div>
                        <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto">
                            <div class="row">
                                <div class="d-flex">
                                    <h3 class="post-page-comment-interactions pe-3 my-0">` +escapeHtml( comment['likes'].toString()) + ` <i title="Like comment" class="far fa-thumbs-up"></i></h3>
                                    <h3 class="post-page-comment-interactions pe-3 my-0">` + escapeHtml(comment['dislikes'].toString()) + ` <i title="Dislike comment" class="far fa-thumbs-down"></i></h3>
                                    <i title="Report comment" class="fas fa-ban my-0 pe-3 post-page-report-comment"></i>
                                    <h3 class="post-page-comment-interactions my-0">` + escapeHtml(comment['thread_count'].toString()) + ` <i class="far fa-comments"></i></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>\n`;
            
            for(let j = 0;j< comment['threads'].length;j++){
                let thread = comment['threads'][j];
                result += `<span class="thread-container"><div class="row justify-content-center px-4 mx-1 thread-section">
                <div class="col-10 mx-0 px-0">
                    <div class="row justify-content-end comment-replies mx-0 px-0">
                        <div class="col-11 post-page-comment-reply reply py-2 pt-2 pb-1 mt-1">
                            <div class="row px-2 py-0">
                                <div class="col-auto p-0 m-0">
                                    <h3 class="post-page-comment-reply-body m-0">` + escapeHtml(thread['comment']['content']) + `</h3>
                                </div><div class=\"col-auto p-0 m-0 ms-auto\">`+
                                `<span class="comment_id" hidden>${thread['comment']['id']}</span>`
                                    +
                                (userID.innerText == thread['comment']['user_id']?
                                `<div class=\"dropdown\">
                            <a class=\"btn fa-cog-icon\"  style=\"font-size:30%;\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">
                                <i class=\"fas fa-cog ms-auto\" style=\"font-size:3em;\"></i>
                            </a>
                            <ul class=\"dropdown-menu dropdown-menu-end\">
                                <a class=\"dropdown-item edit_comment_button\">Edit Comment</a>
                                <li>
                                    <hr class=\"dropdown-divider\">
                                </li>
                                <a class=\"dropdown-item delete_comment_button\" >Delete Comment</a>
                            </ul>
                        </div></div>`:``)

                                +
                            `</div>
                            <div class="row align-items-end px-2 py-0">
                                <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end">
                                    <h3 class="post-page-comment-reply-author-date p-0 m-0">by <a href="${route}">` + escapeHtml(thread['author']) + `</a>, ` + escapeHtml(thread['date']) + `</h3>
                                </div>
                                <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto">
                                    <div class="row">
                                        <div class="d-flex">
                                            <h3 class="post-page-comment-interactions pe-3 my-0">` + escapeHtml(thread['likes'].toString()) + ` <i title="Like comment" class="far fa-thumbs-up"></i></h3>
                                            <h3 class="post-page-comment-interactions pe-3 my-0">` + escapeHtml(thread['dislikes'].toString()) + ` <i title="Dislike comment" class="far fa-thumbs-down"></i></h3>
                                            <i title="Report comment" class="fas fa-ban my-0 post-page-report-comment"></i>
                                            <h3 class="post-page-comment-interactions pe-3 my-0 show-hide-replies" style="white-space:pre;">    <i style="color:black;"title="Show/Hide replies" class="fas fa-chevron-down"></i></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div></span>`;
            }
            result += `<div class="row justify-content-center px-4 mx-1 thread-reply">
                <div class="col-10 mx-0 px-0">
                    <div class="row justify-content-end comment-replies mx-0 px-0">
                        <div class="col-11 post-page-comment-reply-editor px-0 mx-0 mt-1">
                            <div class="row px-0 mx-0">
                                <div class="d-flex mx-0 px-0">
                                        <textarea class="container form-control post-page-add-comment-reply w-100 add-thread" id="add-comment" rows="1"
                                                placeholder="Answer in thread"></textarea>
                                </div>
                            </div>
                            <div class="row px-0 mx-0 justify-content-end">
                                <div class="col-auto px-0">
                                    <span class="thread_comment_id" hidden>` + escapeHtml(comment['comment']['id'].toString()) +`</span>
                                    <button class="post-page-comment-button btn m-0 mt-1 add_thread_button">Comment</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </span>\n`;
            container.innerHTML = result;
            let new_elements = container.getElementsByClassName("delete_comment_button");
            for(let k = 0;k<new_elements.length;k++){
                let temp = new_elements[k];
                let comment_container = temp.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
                let local_cid = temp.parentNode.parentNode.parentNode.getElementsByClassName("comment_id")[0].innerText;
                temp.addEventListener("click",function(e){
                    e.preventDefault();
                    deleteComment(local_cid,comment_container);
                });
            }
            
        }
        else{
            result+=`<div class="row justify-content-center px-4 mx-1 thread-section">
            <div class="col-10 mx-0 px-0">
                <div class="row justify-content-end comment-replies mx-0 px-0">
                    <div class="col-11 post-page-comment-reply reply py-2 pt-2 pb-1 mt-1">
                        <div class="row px-2 py-0">
                            <div class="col-auto p-0 m-0">
                                <h3 class="post-page-comment-reply-body m-0">` + escapeHtml(comment['comment']['content']) + `</h3>
                            </div><div class=\"col-auto p-0 m-0 ms-auto\">`+
                            `<span class="comment_id" hidden>${comment['comment']['id']}</span>`
                            +
                            (userID.innerText == comment['comment']['user_id']?`<div class=\"dropdown\">
                            <a class=\"btn fa-cog-icon\"  style=\"font-size:30%;\" data-bs-toggle=\"dropdown\" aria-expanded=\"false\">
                                <i class=\"fas fa-cog ms-auto\" style=\"font-size:3em;\"></i>
                            </a>
                            <ul class=\"dropdown-menu dropdown-menu-end\">
                                <a class=\"dropdown-item edit_comment_button\">Edit Thread</a>
                                <li>
                                    <hr class=\"dropdown-divider\"></hr>
                                </li>
                                <a class=\"dropdown-item delete_comment_button\" >Delete Thread</a>
                            </ul>
                        </div></div>`:``)
                        +
                        `</div>
                        <div class="row align-items-end px-2 py-0">
                            <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end">
                                <h3 class="post-page-comment-reply-author-date p-0 m-0">by <a href="${route}">` + escapeHtml(comment['author']) + `</a>, ` + escapeHtml(comment['date']) + `</h3>
                            </div>
                            <div class="col-lg-auto col-12 px-0 py-1 m-0 align-self-end ms-auto">
                                <div class="row">
                                    <div class="d-flex">
                                        <h3 class="post-page-comment-interactions pe-3 my-0">` + escapeHtml(comment['likes'].toString()) + ` <i title="Like comment" class="far fa-thumbs-up"></i></h3>
                                        <h3 class="post-page-comment-interactions pe-3 my-0">` + escapeHtml(comment['dislikes'].toString()) + ` <i title="Dislike comment" class="far fa-thumbs-down"></i></h3>
                                        <i title="Report comment" class="fas fa-ban my-0 post-page-report-comment"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>`;
        container.parentNode.parentNode.innerHTML = result;
        let new_elements = container.getElementsByClassName("delete_comment_button");
        for(let k = 0;k<new_elements.length;k++){
            let temp = new_elements[k];
            let comment_container = temp.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
            let local_cid = temp.parentNode.parentNode.parentNode.getElementsByClassName("comment_id")[0].innerText;
            temp.addEventListener("click",function(e){
                e.preventDefault();
                deleteComment(local_cid,comment_container);
            });
        }
            
        }
        
        addDeleteCommentListeners();
        addListeners();
        addEditListeners();
        }
        else{
            alert("Error editing comment!");
            return;
        }
    };
        
        
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send(encodeForAjax({'content':content}));

}
