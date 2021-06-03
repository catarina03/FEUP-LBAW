let homepageFilter = document.querySelector('.homepage .filterButton')
let categoryFilter = document.querySelector('.category .filterButton')
let advancedSearchFilter = document.querySelector('.advanced_search .filterButton')
let homepageSearch = document.querySelector('.homepage #search')
let categorySearch = document.querySelector('.category #search')
let advancedSearchSearch = document.querySelector('.advanced_search #search')
let advancedSearch = document.querySelector('.advanced_search')
let loadMoreAdv = document.querySelector('.advanced_search .pagination-loadmore .loadmore')
let searchElem = document.querySelector('#search')
let categorySelect = document.querySelector('#category')
let typeSelect = document.querySelector('#type')
let startDateElem = null
let endDateElem = null
let peopleFollowCheck = document.querySelector('#checkPeople')
let tagFollowCheck = document.querySelector('#checkTags')
let myPostsCheck = document.querySelector('#checkMyPosts')

let filters = {}
let pageAdv = 2

window.addEventListener('scroll', function(){
    let scrollY = this.scrollY;
    let divScroll = document.querySelector('.go-top-scroll')
    if(scrollY > 560 ){
        if(divScroll.classList.contains('d-none')){
            divScroll.classList.remove('d-none')
            divScroll.classList.add('d-flex')
        }
    }
    else{
        if(divScroll.classList.contains('d-flex')){
            divScroll.classList.remove('d-flex')
            divScroll.classList.add('d-none')
        }
    }
})


if(loadMoreAdv != null) loadMoreAdv.addEventListener('click', (e) => addLoadMoreEventListener(e))

function addLoadMoreEventListener(e){
    e.preventDefault()
    getFilters()
    filters['page'] = pageAdv
    makeRequest('GET', '/api/search?'+ encodeForAjax(filters), loadHandlerAdvancedSearch, null)
}

if(homepageFilter != null) homepageFilter.addEventListener('click', (e) => redirectWithFilters(e) )
if(homepageSearch != null){
    homepageSearch.addEventListener("keyup", (e) => {
        if(e.keyCode === 13){
            redirectWithFilters(e)
        }
    })
}

if(categoryFilter != null) categoryFilter.addEventListener('click', (e) => redirectWithFilters(e))

if(categorySearch != null){
    categorySearch.addEventListener("keyup", (e) => {
        if(e.keyCode === 13){
            redirectWithFilters(e)
        }
    })
}

if(advancedSearch != null) document.addEventListener('DOMContentLoaded', onLoad)

if(advancedSearchSearch != null){
    advancedSearchSearch.addEventListener("keyup", (e) => {
        if(e.keyCode === 13){
            redirectWithFilters(e)
        }
    })
}

if(advancedSearchFilter != null){
    advancedSearchFilter.addEventListener('click', (e) => {
        e.preventDefault()
        let s = addSpinner()
        if(getFilters() !== -1) window.location = "filters?" + encodeForAjax(filters)
        removeSpinner(s)
    })
}

let top_button_advanced = document.querySelector("#advanced-search-go-top")
if(top_button_advanced != null){
    top_button_advanced.addEventListener('click', function(){
        window.scrollTo(0,0)
    })
}



function getFilters(){
    filters = {}
    let search = searchElem.value
    let category = null
    if(categorySelect != null) category = categorySelect.options[categorySelect.selectedIndex].value

    let type = typeSelect.options[typeSelect.selectedIndex].value
    let startDate = startDateElem.value
    let endDate = endDateElem.value
    if(checkDates(startDate, endDate) === -1) return -1


    let peopleFollow = false
    let tagFollow = false
    let myPosts = false
    if(peopleFollowCheck != null) peopleFollow = peopleFollowCheck.checked
    if(tagFollowCheck != null) tagFollow = tagFollowCheck.checked
    if(myPostsCheck != null) myPosts = myPostsCheck.checked


    if(search !== "") filters['search'] = search
    if(type !== "") filters['type'] = type
    if(startDate !== "") filters['startDate'] = startDate
    if(endDate !== "") filters['endDate'] = endDate
    if(peopleFollow !== "") filters['peopleFollow'] = peopleFollow
    if(tagFollow !== "") filters['tagFollow'] = tagFollow
    if(myPosts !== "") filters['myPosts'] = myPosts

    if(category == null){
        let path = window.location.pathname
        const pages = path.split('/')
        if(pages[2] !== null) category = pages[2]
    }

    if(category !== "" && category !== null && category !== undefined) filters['category'] = category
}

function redirectWithFilters(e){
    e.preventDefault()
    let s = addSpinner()
    startDateElem = document.querySelector('input[type="date"]#startDate1')
    endDateElem = document.querySelector('input[type="date"]#endDate1')
    if(getFilters() !== -1) window.location = ("/search/filters?" + encodeForAjax(filters))
    removeSpinner(s)
}

function updateAdvancedSearch(adding, posts, number_res, page){
    const n_res = document.querySelector('.number-res')
    n_res.innerText = number_res + " results found!"
    let pag = document.querySelector('.pagination-loadmore')
    if(pag != null) pag.parentNode.removeChild(pag)
    let postDiv = document.querySelector('.advanced_search .postsCards')
    let newDiv = document.createElement('div')
    if(!adding) postDiv.innerHTML = ""
    newDiv.innerHTML= posts

    while (newDiv.firstChild)
        postDiv.appendChild(newDiv.firstChild)

    if(number_res > 15){
        if(adding){
            if(number_res % 15 === 0) {
                if (Math.floor(number_res) / 15 > page) addLoadMoreAdvancedSearch(postDiv)
            }
            else if(Math.floor(number_res / 15 + 1) > page) addLoadMoreAdvancedSearch(postDiv)
        }
        else addLoadMoreAdvancedSearch(postDiv)
    }
    return postDiv
}

function onLoad(){
    startDateElem = document.querySelector('input[type="date"]#startDate2')
    endDateElem = document.querySelector('input[type="date"]#endDate2')

    const url = new URL(window.location.href)
    url.searchParams.get('search') != null? searchElem.value = url.searchParams.get('search'): searchElem.value = ""
    url.searchParams.get('category') != null? categorySelect.value = url.searchParams.get('category'): categorySelect.value = ""
    url.searchParams.get('type') != null? typeSelect.value = url.searchParams.get('type'): typeSelect.value = ""
    url.searchParams.get('startDate') != null? startDateElem.value = url.searchParams.get('startDate'): startDateElem.value= ""
    url.searchParams.get('endDate') != null? endDateElem.value = url.searchParams.get('endDate'): endDateElem.value = ""
    if(tagFollowCheck != null)  url.searchParams.get('tagFollow') === "true"? tagFollowCheck.checked = true: tagFollowCheck.checked = false
    if(peopleFollowCheck != null) url.searchParams.get('peopleFollow') === "true"? peopleFollowCheck.checked = true: peopleFollowCheck.checked = false
    if(myPostsCheck != null) url.searchParams.get('myPosts') === "true"? myPostsCheck.checked = true: myPostsCheck.checked = false
}

function loadHandlerAdvancedSearch(status, responseText){
    let pag = document.querySelector('.advanced_search .pagination-loadmore')
    let parent = pag.parentNode
    parent.removeChild(pag)

    let outerDiv = addLoadSpinner(parent)
    if(status === 200){
        parent.removeChild(outerDiv)
        const response = JSON.parse(responseText)
        updateAdvancedSearch(true, response['posts'], response['number_res'], pageAdv)
        pageAdv++;
        addSavePostListeners();
    }
    else alert('Error fetching api: ' +  status)


}


function addSpinner(){
    let searchspan = document.querySelector('.search-span')
    searchspan.classList.remove('d-inline-block')
    searchspan.classList.add('d-none')

    let s = document.querySelector('.search-spinner')
    s.classList.remove('d-none')
    s.classList.add('d-inline-block')
}

function removeSpinner(){
    let searchspan = document.querySelector('.search-span')
    searchspan.classList.remove('d-none')
    searchspan.classList.add('d-inline-block')

    let s = document.querySelector('.search-spinner')
    s.classList.remove('d-inline-block')
    s.classList.add('d-none')
}

function checkDates(startDate, endDate){
    let errorSpan = document.querySelector('.error-span')
    let today = new Date()
    if(startDate !== ""){
        let s = new Date(startDate)
        if(s > today){
            errorSpan.innerText = "Start date must be before today"
            return -1
        }
        if(endDate !== ""){
            let e = new Date(endDate)
            if(e < s){
                errorSpan.innerText = "Start date must be before end date"
                return -1
            }
        }
    }
    if(endDate !== ""){
        let e = new Date(endDate)
        if(e > today){
            errorSpan.innerText = "End date must be before today"
            return -1
        }
    }
}

function addLoadMoreAdvancedSearch(postDiv){
    let pagination = document.createElement('div')
    pagination.className = "pagination-loadmore d-flex justify-content-center"

    let load = document.createElement('a')
    load.className = "loadmore"
    load.innerHTML = "Load More"

    pagination.appendChild(load)
    postDiv.appendChild(pagination)
    let loadMore = document.querySelector('.advanced_search .pagination-loadmore .loadmore')
    if(loadMore != null){
        loadMore.addEventListener('click',  (e) => addLoadMoreEventListener(e))
    }
}
