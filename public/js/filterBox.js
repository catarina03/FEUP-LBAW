let homepageFilter = document.querySelector('.homepage .filterButton')
let categoryFilter = document.querySelector('.category .filterButton')
let advancedSearchFilter = document.querySelector('.advanced_search .filterButton')
let advancedSearch = document.querySelector('.advanced_search')

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&')
}
let filters = {}


if(homepageFilter != null) {
    homepageFilter.addEventListener('click', (e) => {
        e.preventDefault()
        redirectWithFilters()
    })
}
if(categoryFilter != null){
    categoryFilter.addEventListener('click', (e) => {
        e.preventDefault()
        redirectWithFilters()
    })
}
if(advancedSearchFilter != null){
    advancedSearchFilter.addEventListener('click', (e) => {
        e.preventDefault()
        let spin = addSpinner()
        getFilters()
        const filterRequest = new XMLHttpRequest()
        filterRequest.onreadystatechange = function(){
            if(filterRequest.readyState === XMLHttpRequest.DONE){
                removeSpinner(spin)
                if(filterRequest.status === 200){
                    let posts = JSON.parse(filterRequest.responseText)
                    updateAdvancedSearch(posts)
                }
                else alert('Error fetching api: ' +  filterRequest.status)
            }
        }
        filterRequest.open('GET', window.location.protocol + "//" + window.location.host + '/api/search/'+ encodeForAjax(filters), true)
        filterRequest.send()

    })
    if(advancedSearch != null) document.addEventListener('DOMContentLoaded', onLoad)
}

let searchElem = document.querySelector(' #search')
let categorySelect = document.querySelector(' #category')
let typeSelect = document.querySelector(' #type')
let startDateElem = document.querySelector(' #startDate')
let endDateElem = document.querySelector('#endDate')
let peopleFollowCheck = document.querySelector('#checkPeople')
let tagFollowCheck = document.querySelector('#checkTags')

function getFilters(){
    filters = {}
    let search = searchElem.value
    let category = null
    if(categorySelect != null) category = categorySelect.options[categorySelect.selectedIndex].value

    let type = typeSelect.options[typeSelect.selectedIndex].value
    let startDate = startDateElem.value
    let endDate = endDateElem.value

    let peopleFollow = false
    let tagFollow = false
    if(peopleFollowCheck!=null) peopleFollow = peopleFollowCheck.checked
    if(tagFollowCheck != null) tagFollow = tagFollowCheck.checked

    let today = new Date()
    if(startDate !== ""){
        let minDate = new Date(startDate)
        if(minDate > today){
            alert("Start date must be before today")
            console.log("here2")
            return -1
        }
        if(endDate !== ""){
            let maxDate = new Date(endDate)
            if(minDate >=  maxDate){
                alert("End date must be greater than start date")
                console.log("here1")
                return -1
            }
        }
    }
    if(endDate !== ""){
        let maxDate = new Date(endDate)
        if(maxDate > today){
            alert("End date must be before today")
            console.log("here3")
            return -1
        }
    }


    if(search !== "") filters['search'] = search
    if(type !== "") filters['type'] = type
    if(startDate !== "") filters['startDate'] = startDate
    if(endDate !== "") filters['endDate'] = endDate
    if(peopleFollow !== "") filters['peopleFollow'] = peopleFollow
    if(tagFollow !== "") filters['tagFollow'] = tagFollow

    if(category == null){
        let url = new URL(window.location.href)
        category = url.searchParams.get('category')
    }

    if(category != null) filters['category'] = category
}

function redirectWithFilters(){
    addSpinner()
    if(getFilters() !== -1) window.location = "search/filters?" + encodeForAjax(filters)
}


//mudar os posts
//mudar os resultados
//mudar o filtrar
//acrescentar loadmore

function updateAdvancedSearch(posts){
    console.log(posts)
    console.log(posts.posts)

    let pag = document.querySelector('.homepage .pagination')
    if(pag != null)
        pag.parentNode.removeChild(pag)
    let postDiv = document.querySelector('.postsCards')
    let newDiv = document.createElement('div')
    postDiv.innerHTML = ""
    newDiv.innerHTML= posts.posts
    while (newDiv.firstChild) {
        postDiv.appendChild(newDiv.firstChild)
    }

    //addLoadMore(postDiv)
}
//fazer load more desta pagina
function onLoad(){
    let url = new URL(window.location.href)
    url.searchParams.get('search') != null? searchElem.value = url.searchParams.get('search'): searchElem.value = ""
    url.searchParams.get('category') != null? categorySelect.value = url.searchParams.get('category'): categorySelect.value = ""
    url.searchParams.get('type') != null? typeSelect.value = url.searchParams.get('type'): typeSelect.value = ""
    url.searchParams.get('startDate') != null? startDateElem.value = url.searchParams.get('startDate'): startDateElem = ""
    url.searchParams.get('endDate') != null? endDateElem.value = url.searchParams.get('endDate'): endDateElem = ""
    url.searchParams.get('tagFollow') === "true"? tagFollowCheck.checked = true: tagFollowCheck.checked = false
    url.searchParams.get('peopleFollow') === "true"? peopleFollowCheck.checked = true: peopleFollowCheck.checked = false
}


function addSpinner(){
    let searchspan = document.querySelector('.search-span')
    searchspan.remove()
    let s = document.querySelector('.search-spinner')
    s.classList.remove('d-none')
    s.classList.add('d-inline-block')
    return s;
}

function removeSpinner(s){
    s.classList.remove('d-inline-block')
    s.classList.add('d-none')

    let b = document.querySelector('.filterButton')
    b.innerHTML = b.innerHTML + '<span class=\"search-span\">Search</span>'
}


