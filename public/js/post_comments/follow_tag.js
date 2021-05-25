function encodeForAjax(data) {
    if (data == null) return null;
    return Object.keys(data).map(function (k) {
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&')
}
let tags = document.getElementsByClassName("follow_tag_icon");
if(tags.length>0){
    for(let i = 0;i<tags.length;i++){
        let element = tags[i];
        element.addEventListener("click",function (e){
            e.stopPropagation();
            e.stopImmediatePropagation();
            let tag_id = element.parentNode.getElementsByClassName("tag_id")[0].innerText;
            follow_tag(tag_id,element);
        });
    }
}

function follow_tag(tag_id,element){
    var list = element.classList;
    followFlag = element.classList.contains("fas");
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    console.log( getUrl .protocol + "//" + getUrl.host + "/" + "api/tag/" + tag_id + "/follow");
    request.open(followFlag?"delete":"post", getUrl .protocol + "//" + getUrl.host + "/" + "api/tag/" + tag_id + "/follow", true);
    request.onload = function (){
        if(request.responseText == "SUCCESS"){
            if(followFlag){
                list.remove("fas");
                list.add("far");
            }
            else{
                list.remove("far");
                list.add("fas"); 
            }
        }
        else{
            alert("Error following or unfollowing tag");
        }
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
}