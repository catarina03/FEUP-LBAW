
let s = document.querySelectorAll(".savePost")[0];

s.addEventListener("click",function () {
    let listClass = s.querySelector("i").classList;

    if (listClass.contains("bi-bookmark-plus-fill")) {
      save_post("post",listClass);
    } else {
      save_post("delete",listClass);
    }
  });


  function save_post(type,listClass){
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    console.log(getUrl.protocol + "//" + getUrl.host + "/api/post"+'/' + id.innerText + "/save");
    request.open(type, getUrl.protocol + "//" + getUrl.host + "/api/post"+'/' + id.innerText + "/save", true);
    request.onload = function (){
        if(request.responseText=="SUCCESS"){
            if(type=="post"){
              listClass.remove("bi-bookmark-plus-fill");
              listClass.add("bi-bookmark-check-fill");
              console.log("ADDED");
            }
            else if(type=="delete"){
              listClass.remove("bi-bookmark-check-fill");
              listClass.add("bi-bookmark-plus-fill");
              console.log("REMOVED");
            }
        }    
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
  }