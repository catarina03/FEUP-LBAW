let loadMore = document.querySelector('.category .pagination .loadmore')
let page = 2
let last = false
const url = new URL(window.location.href)
let category = url.searchParams.get('category')
if(category == null) category = "Music"

if(loadMore != null) loadMore.addEventListener('click', loadHandler)

function loadHandler(e){
    e.preventDefault()

    let pag = document.querySelector('.category .pagination')
    let parent = pag.parentNode
    parent.removeChild(pag)

    let outterDiv = addLoadSpinner(parent)

    const loadRequest = new XMLHttpRequest()
    loadRequest.onreadystatechange = function(){
        if(loadRequest.readyState === XMLHttpRequest.DONE){
            if(loadRequest.status === 200){
                parent.removeChild(outterDiv)
                let posts = JSON.parse(loadRequest.responseText)
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
    loadRequest.open('GET',window.location.protocol +"//" + window.location.host +'/api/category/loadMore/'+ category + '/' + page , true)
    loadRequest.send()
}



