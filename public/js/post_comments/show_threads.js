
addShowThreadListeners();
function addShowThreadListeners(){

    let buttons = document.getElementsByClassName("show-hide-replies");
    for(let i = 0;i<buttons.length;i++){
        let element = buttons[i];
        element.addEventListener("click",function (e){
            //e.preventDefault();
            show_replies(element);
        });
    }
}

function show_replies(element){
    let parent = element.parentNode.parentNode.getElementsByClassName("thread-section");
    let reply = element.parentNode.parentNode.getElementsByClassName("thread-reply")[0];
    for(let j = 0;j<parent.length;j++){
            let temp = parent[j];
            let hidden = temp.getAttribute("hidden");
            if(hidden)
                temp.removeAttribute("hidden");
            
            else
                temp.setAttribute("hidden",true);
        }
        let hiddenH = reply.getAttribute("hidden");
        if(hiddenH){
            reply.removeAttribute("hidden");
        }    
        else{
            reply.setAttribute("hidden",true);
        }
}