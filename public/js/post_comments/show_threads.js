
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
        
    for(let j = 0;j<parent.length;j++){
            let temp = parent[j];
            let reply = temp.parentNode.parentNode.getElementsByClassName("thread-reply")[0];
            let hidden = temp.getAttribute("hidden");
            console.log("Before : " + hidden);
            if(hidden){
                temp.removeAttribute("hidden");
                reply.removeAttribute("hidden");
            }    
            else{
                temp.setAttribute("hidden",true);
                reply.setAttribute("hidden",true);
            }
            console.log("After : " + temp.getAttribute("hidden"));
        }
}