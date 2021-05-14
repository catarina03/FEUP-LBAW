let homepageFilter = document.querySelector('.homepage .filterButton')
let categoryFilter = document.querySelector('.category .filterButton')
let advancedSearchFilter = document.querySelector('.advanced_search .filterButton')
let advancedSearch = document.querySelector('.advanced_search')
let loadMoreAdv = document.querySelector('.advanced_search .pagination .loadmore')
if(loadMoreAdv != null) loadMoreAdv.addEventListener('click', loadHandler)

let filters = {}
let pageAdv = 2

let searchElem = document.querySelector('#search')
let categorySelect = document.querySelector('#category')
let typeSelect = document.querySelector('#type')
let startDateElem = null
let endDateElem = null
let peopleFollowCheck = document.querySelector('#checkPeople')
let tagFollowCheck = document.querySelector('#checkTags')
let myPostsCheck = document.querySelector('#checkMyPosts')


if(homepageFilter != null) {
    homepageFilter.addEventListener('click', (e) => {
        e.preventDefault()
        startDateElem = document.querySelector('input[type="date"]#startDate1')
        endDateElem = document.querySelector('input[type="date"]#endDate1')
        redirectWithFilters()
    })
}
if(categoryFilter != null){
    categoryFilter.addEventListener('click', (e) => {
        e.preventDefault()
        startDateElem = document.querySelector('input[type="date"]#startDate1')
        endDateElem = document.querySelector('input[type="date"]#endDate1')
        redirectWithFilters()
    })
}
if(advancedSearchFilter != null){
    advancedSearchFilter.addEventListener('click', (e) => {
        e.preventDefault()
        let s = addSpinner()
        if(getFilters() !== -1) window.location = "filters?" + encodeForAjax(filters)
        removeSpinner(s)
    })
    if(advancedSearch != null) advancedSearch.addEventListener('DOMContentLoaded', onLoad)
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
    if(peopleFollowCheck!=null) peopleFollow = peopleFollowCheck.checked
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
        let url = new URL(window.location.href)
        category = url.searchParams.get('category')
    }

    if(category !== "" && category !== null) filters['category'] = category
}

function redirectWithFilters(){
    let s = addSpinner()
    if(getFilters() !== -1) window.location = "search/filters?" + encodeForAjax(filters)
    removeSpinner(s)
}

function updateAdvancedSearch(adding, posts, number_res, page){
    let n_res = document.querySelector('.number-res')
    n_res.innerText = number_res + " results found!"
    let pag = document.querySelector('.pagination')
    if(pag != null) pag.parentNode.removeChild(pag)
    let postDiv = document.querySelector('.advanced_search .postsCards')
    let newDiv = document.createElement('div')
    if(!adding) postDiv.innerHTML = ""
    newDiv.innerHTML= posts
    let counter = 0
    while (newDiv.firstChild) {
        postDiv.appendChild(newDiv.firstChild)
        counter++
    }
    if(number_res > 15){
        if(adding){
            if(number_res % 15 === 0){
                if(number_res / 15 !== page) addLoadMore(postDiv)
            }
            else{
                if(number_res/15 + 1 !== page) addLoadMore(postDiv)
            }
        }
        else addLoadMore(postDiv)
    }
    return postDiv
}

function onLoad(){
    startDateElem = document.querySelector('input[type="date"]#startDate2')
    endDateElem = document.querySelector('input[type="date"]#endDate2')
    let url = new URL(window.location.href)
    url.searchParams.get('search') != null? searchElem.value = url.searchParams.get('search'): searchElem.value = ""
    url.searchParams.get('category') != null? categorySelect.value = url.searchParams.get('category'): categorySelect.value = ""
    url.searchParams.get('type') != null? typeSelect.value = url.searchParams.get('type'): typeSelect.value = ""
    url.searchParams.get('startDate') != null? startDateElem.value = url.searchParams.get('startDate'): startDateElem.value= ""
    url.searchParams.get('endDate') != null? endDateElem.value = url.searchParams.get('endDate'): endDateElem.value = ""
    if(tagFollowCheck != null)  url.searchParams.get('tagFollow') === "true"? tagFollowCheck.checked = true: tagFollowCheck.checked = false
    if(peopleFollowCheck != null) url.searchParams.get('peopleFollow') === "true"? peopleFollowCheck.checked = true: peopleFollowCheck.checked = false
    if(myPostsCheck != null) url.searchParams.get('myPosts') === "true"? myPostsCheck.checked = true: myPostsCheck.checked = false
}

function loadHandler(e){
    e.preventDefault()
    let pag = document.querySelector('.advanced_search .pagination')
    let parent = pag.parentNode
    parent.removeChild(pag)

    let outterDiv = addLoadSpinner(parent)
    getFilters()

    const filterRequest = new XMLHttpRequest()
    filterRequest.onreadystatechange = function(){
        if(filterRequest.readyState === XMLHttpRequest.DONE){
            if(filterRequest.status === 200){
                parent.removeChild(outterDiv)
                let posts = JSON.parse(filterRequest.responseText)
                updateAdvancedSearch(true, posts['posts'], posts['number_res'], pageAdv)
                pageAdv++

            }
            else alert('Error fetching api: ' +  filterRequest.status)
        }
    }
    filterRequest.open('GET', window.location.protocol + "//" + window.location.host + '/api/search/'+ encodeForAjax(filters) + "/" + pageAdv, true)
    filterRequest.send()
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

    if(homepageFilter != null ) homepageFilter.innerHTML = '<i class="fa fa-circle-notch fa-spin d-none search-spinner"></i>' + '<span class=\"search-span\">Search</span>'
    if(categoryFilter != null ) categoryFilter.innerHTML = '<i class="fa fa-circle-notch fa-spin d-none search-spinner"></i>' +'<span class=\"search-span\">Search</span>'
    if(advancedSearchFilter != null ) advancedSearchFilter.innerHTML = '<i class="fa fa-circle-notch fa-spin d-none search-spinner"></i>' + '<span class=\"search-span\">Search</span>'
    let b = document.querySelector('.filterButton')
    b.innerHTML = '<span class=\"search-span\">Search</span>'
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
