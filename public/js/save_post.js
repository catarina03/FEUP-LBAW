
let s = document.querySelectorAll(".savePost")[0];
if(s)
  s.addEventListener("click",function (e) {
      e.preventDefault();
      let listClass = s.querySelector("i").classList;

      if (listClass.contains("bi-bookmark-check-fill")) {
        save_post("post",listClass);
      } else {
        save_post("delete",listClass);
      }
    });


  function save_post(type,listClass){
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    request.open(type, getUrl.protocol + "//" + getUrl.host + "/api/post"+'/' + id.innerText + "/save", true);
    request.onload = function (){
        if(request.responseText!="SUCCESS"){
          if(type=="delete"){
            listClass.remove("bi-bookmark-plus-fill");
            listClass.add("bi-bookmark-check-fill");
            alert("Error removing post from favorites!");
          }
          else if(type=="post"){
            listClass.remove("bi-bookmark-check-fill");
            listClass.add("bi-bookmark-plus-fill");
            alert("Error saving post!");
          }  
        }    
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
  }