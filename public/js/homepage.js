let filtering = "top"
let t = document.querySelector(".homepage-navbar a#top");
if(t != null){
    t_posts = 
    t.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "top"
        if(!this.classList.contains('active')){
            this.classList.add('active')
        }
        if(hot.classList.contains('active')){
            hot.classList.remove('active')
        }
        if(new_filter.classList.contains('active')){
            new_filter.remove('active')
        }
        makeRequest("top")   
    }); 
}

let hot = document.querySelector(".homepage-navbar #hot"); 
if(hot != null){
    hot.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "hot"
        if(!this.classList.contains('active')){
            this.classList.add('active')
        }
        if(t.classList.contains('active')){
            t.classList.remove('active')
        }
        if(new_filter.classList.contains('active')){
            new_filter.remove('active')
        }
        
        makeRequest("hot")
    });
}
 

let new_filter = document.querySelector(".homepage-navbar #new");  
if(new_filter != null){
    new_filter.addEventListener("click", function(e){
        e.preventDefault()
        filtering = "new"
        if(!this.classList.contains('active')){
            this.classList.add('active')
        }
        if(hot.classList.contains('active')){
            hot.classList.remove('active')
        }
        if(t.classList.contains('active')){
            t.remove('active')
        }
        makeRequest("new")
    }); 
}


function makeRequest(type){
    const postsRequest = new XMLHttpRequest()
    postsRequest.onreadystatechange = function(){
        if(postsRequest.readyState === XMLHttpRequest.DONE){
            if(postsRequest.status === 200){
                let posts = postsRequest.responseText
                updateHomepage(posts)
            }
            else alert('Error fetching api: ' +  postsRequest.status)
        }
    }
    postsRequest.open('GET', 'api/home/'+ type, true)
    postsRequest.send()
}

function updateHomepage(posts){
    let postDiv = document.querySelector('.postsCards')
    let newDiv = document.createElement('div')
    postDiv.innerHTML = ""
    newDiv.innerHTML= posts
    while (newDiv.firstChild) {
        postDiv.appendChild(newDiv.firstChild)
    }

}

let loadMore = document.querySelector('.homepage .pagination .loadmore')
let page = 1

if(loadMore != null) loadMore.addEventListener('click', loadHandler)

function loadHandler(e){
    e.preventDefault()

    let pag = document.querySelector('.homepage .pagination')
    pag.parentNode.removeChild(pag)
    
    const loadRequest = new XMLHttpRequest()
    loadRequest.onreadystatechange = function(){
        if(loadRequest.readyState === XMLHttpRequest.DONE){
            if(loadRequest.status === 200){
                let posts = loadRequest.responseText
                let postDiv = document.querySelector('.postsCards')
                let newDiv = document.createElement('div')
                newDiv.innerHTML= posts
                while (newDiv.firstChild) {
                    postDiv.appendChild(newDiv.firstChild)
                }
                page++

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
            else alert('Error fetching api: ' +  loadRequest.status)
        }
    }
    loadRequest.open('GET', 'api/loadMore/'+ filtering + '/' + page, true)
    loadRequest.send()
}

/*let slideshow = document.querySelector('.carousel-inner')
let slideshowcards = slideshow.querySelectorAll('.carousel-item')
if(slideshowcards != null){
    slideshowcards.forEach((card)=> card.addEventListener('click', (e) =>{
        e.preventDefault()
        console.log(e.target)
        let id = this.dataset.idcard
        console.log(id)
        //window.location.href = "/post/"+id;
    }))
}*/
