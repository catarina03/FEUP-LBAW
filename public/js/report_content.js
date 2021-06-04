addReportListeners();
function addReportListeners(){
    let report_buttons = document.getElementsByClassName("report_action");
    if(report_buttons.length > 0){
        for(let i = 0;i<report_buttons.length;i++){
            let element = report_buttons[i];
            if(!element.classList.contains("reported")){
                element.addEventListener("click",function(e){
                    e.stopImmediatePropagation();
                    //let list = element.classList;
                    let aux = element.parentNode.getElementsByClassName("content_id")[0];
                    let type = null;
                    if(aux.classList.contains("comment_content"))
                        type = "comment";
                    else if(aux.classList.contains("post_content"))
                        type = "post";
                    if(type == null){
                        alert("Something went wrong with this button!");
                        return;
                    }
                    let content_id = aux.innerText;
                    document.getElementById("report").getElementsByClassName("content_id")[0].innerText = content_id;
                    document.getElementById("report").getElementsByClassName("content_type")[0].innerText = type;
                });
            }
        }
    }
}

let report_motives = document.getElementsByClassName("report_button");
if(report_motives.length>0){
    for(let k = 0;k<report_motives.length;k++){
        let element = report_motives[k];
        element.addEventListener("click",function(e){
            e.preventDefault();
            let type = document.getElementById("report").getElementsByClassName("content_type")[0].innerText;
            let content_id = document.getElementById("report").getElementsByClassName("content_id")[0].innerText;
            report_content(type,content_id,document.getElementById("report").getElementsByClassName("report-motives")[0].getElementsByClassName("report_content_select")[0].value);
        });
    }    
}

function report_content(type,id,value){
    var route;
    const getUrl = window.location;
    if(type == "comment")
        route = getUrl.protocol + "//" + getUrl.host + "/" +'comment/' + id + '/report';
    else if(type=="post")
        route = getUrl.protocol + "//" + getUrl.host + "/" +'post/' + id + '/report';
    let motive = getMotive(value);
    if(motive==null){
        show_generic_warning("Invalid motive");
        return;
    }
    let request = new XMLHttpRequest();
    request.open('post', route, true);
    request.onreadystatechange = function(){
        if(request.readyState === XMLHttpRequest.DONE){
            let text = JSON.parse(request.responseText);
            if(request.status === 200){
                if(type=="comment"){
                    hideReportButtonFromComment(id);
                    show_toaster("Comment reported successfully!");
                }
                else
                    hideReportButtonFromPost();
                    show_toaster("Post reported successfully!");
            }
            else{
                show_generic_warning("Invalid motive");
            }
        }
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send(encodeForAjax({"motive":motive}));
}

function getMotive(value){
    if(value == "fake")
        return "Fake news";
    else if(value == "innapropriate")
        return "Innapropriate content";
    else if(value == "abusive")
        return "Abusive content";
    else if(value == "hate")
        return "Hate speech";
    else if(value == "other")
        return "Other";
    return null;
}


function hideReportButtonFromComment(id){
    let comments = document.querySelectorAll(".content_id.comment_content");
    if(comments.length>0){
        for(let i = 0;i<comments.length;i++){
            let element = comments[i];
            if(element.innerText == id){
                let temp = element.parentNode.getElementsByClassName("report_action")[0];
                temp.setAttribute("style","color:darkred;");
                temp.classList.remove("far");
                temp.classList.add("fas");
                temp.classList.add("reported");
                temp.removeAttribute("data-bs-toggle");
                temp.removeAttribute("data-bs-target");
                return;
            }
        }
    }
    return;
}

function hideReportButtonFromPost(){
    let post_button = document.getElementsByClassName("report_post_button")[0];
    let icon = post_button.getElementsByClassName("report_post_icon")[0];
    icon.classList.remove("far");
    icon.classList.add("fas");
    post_button.setAttribute("style","color:darkred;");
    post_button.classList.add("reported");
    post_button.removeAttribute("data-bs-toggle");
    post_button.removeAttribute("data-bs-target");
    return;
}