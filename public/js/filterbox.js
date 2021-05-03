let filterButton = document.querySelector('.filterButton')

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&')
}

if(filterButton != null){
    filterButton.addEventListener('click', (e) => {
        e.preventDefault();
        let search = document.querySelector('#search').value
        let typeSelect = document.querySelector('#type')
        let type = typeSelect.options[typeSelect.selectedIndex].value
        let startDate = document.querySelector('#startDate').value
        let endDate = document.querySelector('#endDate').value
        let peopleFollowCheck = document.querySelector('#checkPeople')
        let peopleFollow = false
        if(peopleFollowCheck.checked) peopleFollow = true
        let tagFollowCheck = document.querySelector('#checkTags').value
        let tagFollow = false
        if(tagFollowCheck.checked) tagFollow = true
        let filters = {}
        if(search !== "") filters[search] = search
        if(type !== "") filters[type] = type  
        if(startDate !== "") startDate[search] = startDate
        if(endDate !== "") filters[endDate] = endDate
        if(peopleFollow !== "") filters[peopleFollow] = peopleFollow
        if(tagFollow !== "") filters[tagFollow] = tagFollow

        const filterRequest = new XMLHttpRequest()
        filterRequest.onreadystatechange = function(){
            if(filterRequest.readyState === XMLHttpRequest.DONE){
                if(filterRequest.status === 200){
                    console.log("Filtered")
                    window.location = "/advanced_search"
                }
                else alert('Error filtering api: ' +  filterRequest.response)
            }
        }
        filterRequest.open('GET', 'api/post_filter/'+ encodeForAjax(filters), true)
        filterRequest.send()
    })
}