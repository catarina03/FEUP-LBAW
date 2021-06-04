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
        if(request.status==400){
            show_generic_warning("Internal error when adding comment!");
            //alert("Error adding comment");
            content.setAttribute("rows","2");
            return;
        }
        else if(request.status==200){
            let temp = request.responseText;
            temp+=document.getElementById("comment-section").innerHTML;
            document.getElementById("comment-section").innerHTML = temp;
            content.value = "";
            addListeners();
            addDeleteCommentListeners();
            addEditListeners();
            addShowThreadListeners();
            updateCommentCount(1);
            EmptyCommentsVisibility(true);
            addThreadTextListener();
            addReportListeners();
            let comments = document.querySelectorAll('.comment-container');
            if(comments != null) comments.forEach((comment) => addCommentsEventListeners(comment));
            content.setAttribute("rows","2");
        }
        
        
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    if(content.value=="" || content.value.match("^\\s+$") || content.value.length>1000){
        //show_generic_warning("Empty comments are not allowed!");
        addCommentError(content);
        return;
    }
    remove_error_messages();
    request.send(encodeForAjax({content:content.value,post_id:id.innerText,user_id:userID.innerText}));
}





function addCommentTextListener(){
    let c = document.getElementById("add-comment");
    if(c){
        c.addEventListener("keyup",function(e){
            e.preventDefault();
            if (e.keyCode === 13) {
                let rows = parseInt(c.getAttribute("rows"));
                c.setAttribute("rows",rows+1);
            }
        });
    }
}

function addThreadTextListener(){
    let c = document.getElementsByClassName("add-thread");
    if(c && c.length>0){
        for(let i = 0;i<c.length;i++){
            let temp = c[i];
            temp.addEventListener("keyup",function(e){
                if (e.keyCode === 13) {
                    let rows = parseInt(temp.getAttribute("rows"));
                    temp.setAttribute("rows",rows+1);
                }
            });
        }
    }
}

addCommentTextListener();
addThreadTextListener();
