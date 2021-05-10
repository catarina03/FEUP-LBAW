let filtering = "top"

let t = document.querySelector(".homepage-navbar a#top")
let loadT = document.querySelector(".homepage-navbar .topLoad")
if(t != null && loadT != null){
    t.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "top"
        displaySpinner(true, "top")
        makeRequest(filtering)
        setActive(this, hot, new_filter)
    });
}

let hot = document.querySelector(".homepage-navbar #hot");
let loadH = document.querySelector(".homepage-navbar .hotLoad")
if(hot != null && loadH != null){
    hot.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "hot"
        displaySpinner(true, "hot")
        makeRequest(filtering)
        setActive(this,t,new_filter)
    });
}


let new_filter = document.querySelector(".homepage-navbar #new")
let loadN = document.querySelector(".homepage-navbar .newLoad")
if(new_filter != null && loadN != null){
    new_filter.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "new"
        displaySpinner(true, "new")
        makeRequest(filtering)
        setActive(this, hot, top)
    });
}

function setActive(current, firstNotActive, secondNotActive){
    if(current.classList.contains('active')) current.classList.add('active')
    if(firstNotActive.classList.contains('active')) firstNotActive.classList.remove('active')
    if(secondNotActive.classList.contains('active')) secondNotActive.classList.remove('active')
}

function makeRequest(type){
    const postsRequest = new XMLHttpRequest()
    postsRequest.onreadystatechange = function(){
        if(postsRequest.readyState === XMLHttpRequest.DONE){
            if(postsRequest.status === 200){
                let posts = postsRequest.responseText
                updateHomepage(posts)
                displaySpinner(true, type)
            }
            else alert('Error fetching api: ' +  postsRequest.status)
        }
    }
    postsRequest.open('GET', 'api/home/'+ type, true)
    postsRequest.send()
}

function updateHomepage(posts){
    let pag = document.querySelector('.homepage .pagination')
    if(pag != null)
        pag.parentNode.removeChild(pag)
    let postDiv = document.querySelector('.postsCards')
    let newDiv = document.createElement('div')
    postDiv.innerHTML = ""
    newDiv.innerHTML= posts
    while (newDiv.firstChild) {
        postDiv.appendChild(newDiv.firstChild)
    }
    addLoadMore(postDiv)
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

    if(type === "news"){
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





let loadMore = document.querySelector('.homepage .pagination .loadmore')
let page = 1
let last = false

if(loadMore != null) loadMore.addEventListener('click', loadHandler)

function loadHandler(e){
    e.preventDefault()

    let pag = document.querySelector('.homepage .pagination')
    if(pag != null) pag.parentNode.removeChild(pag)

    const loadRequest = new XMLHttpRequest()
    loadRequest.onreadystatechange = function(){
        if(loadRequest.readyState === XMLHttpRequest.DONE){
            if(loadRequest.status === 200){
                let posts = loadRequest.responseText
                let postDiv = document.querySelector('.postsCards')
                let newDiv = document.createElement('div')
                newDiv.innerHTML= posts

                let counter = 0
                while (newDiv.firstChild) {
                    counter++
                    postDiv.appendChild(newDiv.firstChild)
                }
                page++
                if(counter < 15) last = true

                if(!last){
                    addLoadMore(postDiv)
                }

            }
            else alert('Error fetching api: ' +  loadRequest.status)
        }
    }
    loadRequest.open('GET', 'api/loadMore/'+ filtering + '/' + page, true)
    loadRequest.send()
}


function addLoadMore(postDiv){
    let pagination = document.createElement('div')
    pagination.className = "pagination d-flex justify-content-center"

    let load = document.createElement('a')
    load.className = "loadmore"
    load.innerHTML = "Load More"

    pagination.appendChild(load)
    postDiv.appendChild(pagination)
    let loadMore = document.querySelector('.homepage .pagination .loadmore')
    if(loadMore != null){
        loadMore.addEventListener('click', loadHandler)
    }
}

