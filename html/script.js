let savePosts = document.querySelectorAll(".card .savePost")

savePosts.forEach(item =>
    item.addEventListener('click', function(){
        let listClass = item.querySelector("i").classList
        
        if(listClass.contains("bi-bookmark-plus-fill")) {
            listClass.remove("bi-bookmark-plus-fill")
            listClass.add("bi-bookmark-check-fill")
        }
        else {
            listClass.remove("bi-bookmark-check-fill")
            listClass.add("bi-bookmark-plus-fill")
        }
    }))