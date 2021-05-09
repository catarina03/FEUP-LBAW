let roles = document.getElementsByClassName("role-item")
if (roles != null) {
    for (let i = 0; i < roles.length; i++)
        roles[i].addEventListener("click", edit_role)
}

function edit_role(event) {
    event.preventDefault()
    let row = event.target.closest('.role-row')
    const person_id = row.dataset.id
    const new_role = event.target.innerText
    let old_role = row.getElementsByClassName("roles-role")[0]

    let request = new XMLHttpRequest()
    const url = window.location.protocol + "//" + window.location.host + '/api/administration/roles/' + person_id + '/edit_role'
    console.log(url)

    request.open('put', url, true)
    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 200) old_role.innerText = new_role
            else alert("Sorry! There was an error " + request.status)
        }
    }

    request.send(encodeForAjax({new_role: new_role}))
}

let roles_list = document.querySelector(".roles-list")
let search = document.getElementById("search")
let searchButton = document.getElementById("search-addon")
if(search != null) search.addEventListener('keyup', search_username)
if(searchButton != null) searchButton.addEventListener('click', search_username)

function search_username(event) {
    event.preventDefault()
    roles_list.innerHTML = ""
    let spinner = document.querySelector(".spinner")
    spinner.classList.remove("d-none")
    spinner.classList.add("d-flex")

    const url = window.location.protocol + "//" + window.location.host + '/api/administration/roles?query=' + search.value
    sendRequest(url)
}

function sendRequest(url) {
    let request = new XMLHttpRequest()
    request.open('get', url, true)
    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 200) {
                updateRolesList(this.responseText)
            } else {
                alert("something happen " + request.status)
            }
        }
    }
    request.send()
}

function updateRolesList(response) {
    alert(response)
}
