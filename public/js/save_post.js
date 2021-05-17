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
          let inverted = aux.classList.contains("homepage");
          if (listClass.contains(!inverted?"bi-bookmark-check-fill":"bi-bookmark-plus-fill")) {
            save_post("post",element.querySelector("i").classList,post_id,inverted);
          } else {
            save_post("delete",element.querySelector("i").classList,post_id,inverted);
          }
        });
    }
  }
}

  function save_post(type,listClass,post_id,inverted){
    let token = document.getElementsByName("csrf-token")[0];
    var getUrl = window.location;
    var request = new XMLHttpRequest();
    request.open(type, getUrl.protocol + "//" + getUrl.host + "/api/post"+'/' + post_id + "/save", true);
    request.onload = function (){
        if(request.responseText!="SUCCESS"){
          if(type=="delete"){
            
            listClass.remove(!inverted?"bi-bookmark-plus-fill":"bi-bookmark-check-fill");
            listClass.add(!inverted?"bi-bookmark-check-fill":"bi-bookmark-plus-fill");
            
            alert("Error removing post from favorites!");
          }
          else if(type=="post"){
            
            listClass.remove(!inverted?"bi-bookmark-check-fill":"bi-bookmark-plus-fill");
            listClass.add(!inverted?"bi-bookmark-plus-fill":"bi-bookmark-check-fill");
            
            alert("Error saving post!");
          }  
        }
        else{
          if(inverted){
            if(type=="post"){
              listClass.remove("bi-bookmark-plus-fill");
              listClass.add("bi-bookmark-check-fill");
            }
            if(type=="delete"){
              listClass.remove("bi-bookmark-check-fill");
              listClass.add("bi-bookmark-plus-fill");
            }

          }
        }    
    };
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
  }