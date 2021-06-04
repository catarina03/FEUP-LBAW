addSavePostListeners();
function addSavePostListeners(){
  let s = document.querySelectorAll(".savePost");
  if(s.length > 0){
    for(let i =0;i<s.length;i++){
      let element = s[i];
      element.addEventListener("click",function (e) {
          e.stopImmediatePropagation();
          let listClass = element.querySelector("i").classList;
          let aux = element.getElementsByClassName("save_post_id")[0];
          let post_id = aux.innerText;
          if (listClass.contains("bi-bookmark-plus-fill")) {
            save_post("post",element.querySelector("i").classList,post_id);
          } else {
            save_post("delete",element.querySelector("i").classList,post_id);
          }
        });
    }
  }
}

  function save_post(type,listClass,post_id){
    let token = document.getElementsByName("csrf-token")[0];
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    console.log(getUrl.protocol + "//" + getUrl.host + "/api/post"+'/' + post_id + "/save");
    request.open(type, getUrl.protocol + "//" + getUrl.host + "/api/post"+'/' + post_id + "/save", true);
    request.onload = function (){
      console.log(request.responseText);
        if(request.responseText!="SUCCESS"){
          if(type=="delete"){
            show_generic_wawrning("Error removing post from favorites!");
          }
          else if(type=="post"){
            show_generic_warning("Error saving post!");
          }  
        }
        else{
            if(type=="post"){
              listClass.remove("bi-bookmark-plus-fill");
              listClass.add("bi-bookmark-check-fill");
              show_toaster("Post successfully added to favorites!");
              
            }
            if(type=="delete"){
              listClass.remove("bi-bookmark-check-fill");
              listClass.add("bi-bookmark-plus-fill");
              show_toaster("Post successfully removed from favorites!");
              
            }
        }    
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
  }