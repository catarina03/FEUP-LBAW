
addShowThreadListeners();
function addShowThreadListeners(){

    let buttons = document.getElementsByClassName("show-hide-replies");
    if(buttons!=null && buttons.length>0)
    for(let i = 0;i<buttons.length;i++){
        let element = buttons[i];
        element.addEventListener("click",function (e){
            //e.preventDefault();
            e.stopImmediatePropagation();
            show_replies(element);
        });
    }
}

function show_replies(element){
    /*let parent = element.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.getElementsByClassName("thread-section");
    let reply = element.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.getElementsByClassName("thread-reply")[0];
    for(let j = 0;j<parent.length;j++){
            let temp = parent[j];
            let hidden = temp.getAttribute("hidden");
            if(hidden=="")
                temp.removeAttribute("hidden");
            
            else
                temp.setAttribute("hidden","");
        }
        let hiddenH = reply.getAttribute("hidden");
        let k = element.getElementsByTagName("i")[0];
        if(hiddenH==""){
            reply.removeAttribute("hidden");
            
            element.innerHTML = `<i class="fas fa-chevron-down my-0" style="cursor:pointer;"></i>Hide`;
        }    
        else{
            reply.setAttribute("hidden","");
            element.innerHTML = `<i class="fas fa-chevron-right my-0" style="cursor:pointer;"></i>Show`;
        }*/
        let aux = element.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
        let temp = aux.getElementsByClassName("comment_thread_section")[0];
        if(temp.classList.contains("d-none")){
            temp.classList.remove("d-none");
            element.innerHTML = `<i class="fas fa-chevron-down my-0" style="cursor:pointer;"></i>Hide`;
        }
        else{
            temp.classList.add("d-none");
            element.innerHTML = `<i class="fas fa-chevron-right my-0" style="cursor:pointer;"></i>Show`;
        }
        let reply = element.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.getElementsByClassName("thread-reply")[0];
        if(reply.classList.contains("d-none")){
            reply.classList.remove("d-none");
        }
        else{
            reply.classList.add("d-none");
        }
    
}