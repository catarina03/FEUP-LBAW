let verify = false;
let s = document.querySelectorAll(".savePost")[0];
s.addEventListener("click", function () {
    let listClass = s.querySelector("i").classList;

    if (listClass.contains("bi-bookmark-plus-fill")) {
      listClass.remove("bi-bookmark-plus-fill");
      addSave();
      if(verify)
        listClass.add("bi-bookmark-check-fill");
        verify = false;
      
    } else {
      listClass.remove("bi-bookmark-check-fill");
      deleteSave();
      if(verify)
        listClass.add("bi-bookmark-plus-fill");
        verify = false;
      
    }
  });


  function addSave(){
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    var request = new XMLHttpRequest();
    request.open('post', getUrl .protocol + "//" + getUrl.host + "/api/post"+'/' + id.innerText + "/save", true);
    request.onload = function (){
        if(request.responseText=="SUCCESS"){
            verify = true;
            console.log("ADDED!");
        }    
    }
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
  }

  function deleteSave(){
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1];
    var request = new XMLHttpRequest();
    request.open('post',getUrl .protocol + "//" + getUrl.host + "/api/post/" + id.innerText + "/save", true);
    request.onload = function (){
        if(request.responseText=="SUCCESS"){
            verify = true;
            console.log("REMOVED!");
        }    
    }
    request.setRequestHeader('X-CSRF-TOKEN',token.getAttribute("content"));
    request.send();
  }