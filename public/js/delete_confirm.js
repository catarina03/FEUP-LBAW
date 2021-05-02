let confirm = document.getElementById("confirm");
let yes = confirm.getElementsByClassName("col-2 btn custom-button")[0];
let id = document.getElementById("post_ID");
let token = document.getElementsByName("csrf-token")[0];
yes.addEventListener("click",delete_post);

function delete_post(){
    console.log("fdc");
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    var request = new XMLHttpRequest();
    request.open('delete', baseUrl+'/' + id.innerText, true);
    request.onload = function (){
        console.log(baseUrl+"/" + request.responseText);
        window.location.href = getUrl .protocol + "//" + getUrl.host + "/"+ request.responseText;
    }
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
}