let loadMore = document.querySelector('.category .pagination .loadmore')
let page = 2
let last = false

if(loadMore != null) loadMore.addEventListener('click', loadHandler)

function loadHandler(e){
    e.preventDefault()
    let url = new URL(window.location.href)
    let category = url.searchParams.get('category')

    if(category == null) category = "Music"

    let pag = document.querySelector('.category .pagination')
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
    loadRequest.open('GET', window.location.protocol +"//" + window.location.host +'/api/category/loadMore/'+ category + '/' + page, true)
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
    let loadMore = document.querySelector('.category .pagination .loadmore')
    if(loadMore != null){
        loadMore.addEventListener('click', loadHandler)
    }
}
