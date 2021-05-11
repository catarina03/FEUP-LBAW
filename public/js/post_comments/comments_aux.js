function updateThreadsNo(ammount,comment_id){
    let container = document.getElementsByClassName("comment-container");
    for(let i =0;i<container.length;i++){
        let cur_id = container[i].getElementsByClassName("thread_comment_id")[0].innerText;
        console.log(cur_id + " " + comment_id);
        
        if(cur_id == comment_id){

            let thread_count = container[i].getElementsByClassName("post-page-comment-interactions")[2];
            console.log(thread_count.innerText);
            thread_count.innerHTML= parseInt(thread_count.innerText) + ammount + " <i class=\"far fa-comments\"></i>";
            return true;
        }

    }
    return false;
}

function min_path(node1, node2) {
    if(node1 === node2) {
        return node1;
    }

    var node_1_ancestors = get_ancestors(node1);
    var node_2_ancestors = get_ancestors(node2);

    var divergent_index = 0;
    while(node_1_ancestors[divergent_index] === node_2_ancestors[divergent_index]) {
        divergent_index++;
    }

    var path = [];
    for(var i = node_1_ancestors.length - 1; i >= divergent_index - 1; i--) {
        path.push(node_1_ancestors[i]);
    }
    for(var i = divergent_index; i < node_2_ancestors.length; i++) {
        path.push(node_2_ancestors[i]);
    }

    return path;
}

function get_ancestors(node) {
    var ancestors = [node];
    while(ancestors[0] !== null) {
        ancestors.unshift(ancestors[0].parentElement);
    }
    return ancestors;
}