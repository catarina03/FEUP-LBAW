function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&')
}

function addLoadMore(postDiv){
    let pagination = document.createElement('div')
    pagination.className = "pagination d-flex justify-content-center"

    let load = document.createElement('a')
    load.className = "loadmore"
    load.innerHTML = "Load More"

    pagination.appendChild(load)
    postDiv.appendChild(pagination)
    let loadMore = document.querySelector('.pagination .loadmore')
    if(loadMore != null){
        loadMore.addEventListener('click', loadHandler)
    }
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



