
let s = document.querySelectorAll(".savePost")[0];
if(s)
  s.addEventListener("click",function (e) {
      e.preventDefault();
      let listClass = s.querySelector("i").classList;
      let post_id = s.getElementsByClassName("save_post_id")[0].innerText;
      if (listClass.contains("bi-bookmark-check-fill")) {
        save_post("post",listClass,post_id);
      } else {
        save_post("delete",listClass,post_id);
      }
    });


  function save_post(type,listClass,post_id){
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    request.open(type, getUrl.protocol + "//" + getUrl.host + "/api/post"+'/' + post_id + "/save", true);
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