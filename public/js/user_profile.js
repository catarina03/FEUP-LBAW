let loadMore = document.querySelector('.profile .pagination-loadmore .loadmore')
let page = 2
const NUMBER_OF_POSTS = 6

if(loadMore != null) loadMore.addEventListener('click', loadHandlerHomepage)

function loadHandlerHomepage(e){
    e.preventDefault()
    let pag = document.querySelector('.profile .pagination-loadmore')
    let parent = pag.parentNode
    parent.removeChild(pag)

    let outterDiv = addLoadSpinner(parent)

    var getUrl = window.location;
    const loadRequest = new XMLHttpRequest()
    loadRequest.onreadystatechange = function(){
        if(loadRequest.readyState === XMLHttpRequest.DONE){
            console.log(loadRequest.responseText)
            if(loadRequest.status === 200){
                console.log(loadRequest.responseText)
                parent.removeChild(outterDiv)
                const response = JSON.parse(loadRequest.responseText)
                const posts = response['posts']
                const n_posts = response['n_posts']
                let postDiv = document.querySelector('.postsCards')
                let newDiv = document.createElement('div')
                newDiv.innerHTML= posts

                while (newDiv.firstChild)
                    postDiv.appendChild(newDiv.firstChild)

                if(n_posts > NUMBER_OF_POSTS){
                    if(n_posts % NUMBER_OF_POSTS === 0) {
                        if (Math.floor(n_posts) / NUMBER_OF_POSTS > page) addLoadMoreHomepage(postDiv)
                    }
                    else if(Math.floor(n_posts / NUMBER_OF_POSTS + 1) > page) addLoadMoreHomepage(postDiv)
                }
                page++;
                //addSavePostListeners();
            }
            else alert('Error fetching api: ' +  loadRequest.status)
        }
    }
    loadRequest.open('get', getUrl.protocol + "//" + getUrl.host + '/api/user/' + user_id.value + '/load_more/' + page , true)
    loadRequest.send()
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


function addLoadMoreHomepage(postDiv){
    let pagination = document.createElement('div')
    pagination.className = "pagination-loadmore d-flex justify-content-center"

    let load = document.createElement('a')
    load.className = "loadmore"
    load.innerHTML = "Load More"

    pagination.appendChild(load)
    postDiv.appendChild(pagination)
    let loadMore = document.querySelector('.profile .pagination-loadmore .loadmore')
    if(loadMore != null) loadMore.addEventListener('click', loadHandlerHomepage)
}


function addLoadSpinner(parent){
    let outterDiv = document.createElement('div')
    outterDiv.classList = "d-flex justify-content-center"
    let spinnerDiv = document.createElement('div')
    spinnerDiv.classList = "spinner-border spinner-border-sm text-center"
    let spinner = document.createElement('span')
    spinner.classList = "visually-hidden"
    spinner.innerText = "Loading..."

    spinnerDiv.appendChild(spinner)
    outterDiv.appendChild(spinnerDiv)
    parent.appendChild(outterDiv)
    return outterDiv
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




