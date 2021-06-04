let filtering = "top"
let t = document.querySelector(".homepage-navbar a#top")
let loadT = document.querySelector(".homepage-navbar .topLoad")
let hot = document.querySelector(".homepage-navbar #hot");
let loadH = document.querySelector(".homepage-navbar .hotLoad")
let new_filter = document.querySelector(".homepage-navbar #new")
let loadN = document.querySelector(".homepage-navbar .newLoad")
let top_button = document.querySelector("#go-top")

if(top_button != null){
    top_button.addEventListener('click', function(){
        window.scrollTo(0,0)
    })
}

if(t != null && loadT != null){
    t.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "top"
        displaySpinner(true, "top")
        setActive(t, hot, new_filter)
        disableLinks(hot, new_filter)
        makeRequest('GET', 'api/home/'+ filtering, receiveRequestHandler, null)
    });
}

if(hot != null && loadH != null){
    hot.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "hot"
        displaySpinner(true, "hot")
        setActive(hot,t,new_filter)
        disableLinks(t, new_filter)
        makeRequest('GET', 'api/home/'+ filtering, receiveRequestHandler, null)
    });
}

if(new_filter != null && loadN != null){
    new_filter.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "new"
        displaySpinner(true, "new")
        setActive(new_filter, t, hot)
        disableLinks(t, hot)
        makeRequest('GET', 'api/home/'+ filtering, receiveRequestHandler, null)
    });
}

function setActive(current, firstNotActive, secondNotActive){
    if(!current.classList.contains('active')) current.classList.add('active')
    if(firstNotActive.classList.contains('active')) firstNotActive.classList.remove('active')
    if(secondNotActive.classList.contains('active')) secondNotActive.classList.remove('active')
}

function receiveRequestHandler(status, responseText){
    if(status === 200){
        const response = JSON.parse(responseText)
        let posts = response['posts']
        let n_posts = response['n_posts']
        window.scrollTo(0,0)
        updateHomepage(posts, n_posts)
        displaySpinner(false, filtering)
        enableLinks(filtering)
    }
    else if(status === 400){
        show_generic_warning("Error filtering homepage: " + responseText)
    }
}

function updateHomepage(posts, n_posts){
    let pag = document.querySelector('.homepage .pagination-loadmore')
    if(pag != null)
        pag.parentNode.removeChild(pag)
    let postDiv = document.querySelector('.postsCards')
    let newDiv = document.createElement('div')
    postDiv.innerHTML = ""
    newDiv.innerHTML= posts
    while (newDiv.firstChild)  postDiv.appendChild(newDiv.firstChild)
    if(n_posts > 15 )
        addLoadMoreHomepage(postDiv)
}

function displaySpinner(display, type){
    if(type === "top"){
        if(display && loadT.classList.contains('d-none')) {
            loadT.classList.remove('d-none')
            loadT.classList.add('d-inline-block')
        }
        else if(loadT.classList.contains('d-inline-block')){
            loadT.classList.remove('d-inline-block')
            loadT.classList.add('d-none')
        }
    }
    if(type === "hot"){
        if(display  && loadH.classList.contains('d-none')){
            loadH.classList.remove('d-none')
            loadH.classList.add('d-inline-block')
        }
        else if(loadH.classList.contains('d-inline-block')){
            loadH.classList.remove('d-inline-block')
            loadH.classList.add('d-none')
        }
    }

    if(type === "new"){
        if(display && loadN.classList.contains('d-none')){
            loadN.classList.remove('d-none')
            loadN.classList.add('d-inline-block')
        }
        else if(loadN.classList.contains('d-inline-block')){
            loadN.classList.remove('d-inline-block')
            loadN.classList.add('d-none')
        }
    }
}


let loadMore = document.querySelector('.homepage .pagination-loadmore .loadmore')
let page = 2
let outerDiv = null
let parent = null
if(loadMore != null){
    loadMore.addEventListener('click', (e) => addEventListenersLoadHomepage(e))
}


function addEventListenersLoadHomepage(e){
    e.preventDefault()
    let pag = document.querySelector('.homepage .pagination-loadmore')
    parent = pag.parentNode
    parent.removeChild(pag)

    outerDiv = addLoadSpinner(parent)
    makeRequest('GET','/api/loadMore/'+ filtering + '/' + page , receiveLoadMoreHandler, null)
}

function receiveLoadMoreHandler(status, responseText){

    if(status === 200){
        parent.removeChild(outerDiv)
        const response = JSON.parse(responseText)
        const posts = response['posts']
        const n_posts = response['n_posts']
        let postDiv = document.querySelector('.postsCards')
        let newDiv = document.createElement('div')
        newDiv.innerHTML= posts

        while (newDiv.firstChild)
            postDiv.appendChild(newDiv.firstChild)

        if(n_posts > 15){
            if(n_posts % 15 === 0) {
                if (Math.floor(n_posts) / 15 > page) addLoadMoreHomepage(postDiv)
            }
            else if(Math.floor(n_posts / 15 + 1) > page) addLoadMoreHomepage(postDiv)
        }
        page++;
        addSavePostListeners();
    }
    else show_generic_warning("Error fetching more posts: " + responseText)
}


function addLoadMoreHomepage(postDiv){
    let pagination = document.createElement('div')
    pagination.className = "pagination-loadmore d-flex justify-content-center"

    let load = document.createElement('a')
    load.className = "loadmore"
    load.innerHTML = "Load More"

    pagination.appendChild(load)
    postDiv.appendChild(pagination)
    let loadMore = document.querySelector('.homepage .pagination-loadmore .loadmore')
    if(loadMore != null){
        loadMore.addEventListener('click', (e) => addEventListenersLoadHomepage(e))
    }
}

function enableLinks(type){
    if(type === "top"){
        first = hot
        second = new_filter
    }
    else if(type === "hot"){
        first = t
        second = new_filter
    }
    else{
        first = t
        second = hot
    }
    first.style.pointerEvents="auto";
    first.style.cursor="pointer";
    second.style.pointerEvents="auto";
    second.style.cursor="pointer";
}

function disableLinks(first, second){
    first.style.pointerEvents="none";
    first.style.cursor="default";
    second.style.pointerEvents="none";
    second.style.cursor="default";

}





