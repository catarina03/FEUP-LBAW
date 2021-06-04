addRolesListener()
addRowsLinks()

function addRolesListener() {
    let roles_items = document.querySelectorAll(".edit-roles button")
    if (roles_items != null) {
        for (let i = 0; i < roles_items.length; i++) {
            roles_items[i].addEventListener("click", edit_role_modal)
        }
    }
}

function addRowsLinks() {
    let rows = document.querySelectorAll(".role-item");
    if (rows != null) {
        for (let i = 0; i < rows.length; i++) {
            rows[i].addEventListener("click", function (event) {
                event.preventDefault()
                let ev = event.target.closest(".role-user")
                if (ev != null) {
                    let id = ev.dataset.id.replaceAll("'", "")
                    window.location.href = window.location.protocol + "//" + window.location.host + "/user/" + id
                }
            })
        }
    }

}

let modal = document.querySelector('.edit_role_modal')
let nmodal = new bootstrap.Modal(modal, {})
let error = document.querySelector(".motive-error")

function edit_role_modal(event) {
    event.preventDefault()
    let row = event.target.closest(".role-user")
    const person_id = row.dataset.id
    const person_role = row.dataset.role

    modal.dataset.id = person_id
    let el = modal.querySelector(".edit_role_select")
    el.innerHTML = ""

    let r = document.createElement("option")
    r.selected = true
    r.disabled = true
    r.text = "Select a role"
    el.append(r)

    let roles = ["System Manager", "Moderator", "Regular"]
    roles.forEach(function (role, index, array) {
        if (role !== person_role) {
            let r = document.createElement("option")
            r.value = role
            r.text = role
            el.append(r)
        }
    })

    error.classList.remove("d-block")
    error.classList.add("d-none")
    nmodal.show()

    let confirm_yes = document.querySelector('.edit_button')
    if (confirm_yes != null) confirm_yes.addEventListener("click", edit_role)
}


function edit_role(event) {
    event.preventDefault()

    const person_id = modal.dataset.id
    const element = document.getElementById("selectNewRole")
    const new_role = element.options[element.selectedIndex].value

    if (new_role === "Select a role") {
        error.classList.remove("d-none")
        error.classList.add("d-block")
    } else {
        error.classList.remove("d-block")
        error.classList.add("d-none")
        nmodal.hide()

        let old_role = document.querySelector(`[data-id="${person_id}"] .roles`)
        old_role.innerHTML = "Pending..."

        const url = window.location.protocol + "//" + window.location.host + '/api/administration/roles/' + person_id + '/edit_role'
        makeRequest("PUT", url, handleEditRoleResponse, encodeForAjax({new_role: new_role}))
    }
}

function handleEditRoleResponse(status, responseText) {
    let res = JSON.parse(responseText)
    let view = res['view']
    let id = res['id']
    if (status !== 200) {
        alert("Error editing role") //pass to toast
    } else {
        document.querySelector(`.role-user[data-id="${id}"]`).dataset.role = res['new_role']
    }

    let el = document.querySelector(`[data-id="${id}"] .roles`)
    el.innerHTML = view

    let roles_item = el.querySelector("button")
    roles_item.addEventListener("click", edit_role_modal)
}


let roles_list = document.querySelector(".roles-list")
let search = document.getElementById("search")
let searchButton = document.getElementById("search-addon")
if (search != null) search.addEventListener('keyup', search_username)
if (searchButton != null) searchButton.addEventListener('click', search_username)

function search_username(event) {
    event.preventDefault()
    roles_list.innerHTML = ""
    let spinner = document.querySelector(".spinner")
    spinner.classList.remove("d-none")
    spinner.classList.add("d-flex")

    const url = window.location.protocol + "//" + window.location.host + '/api/administration/roles?query=' + search.value
    makeRequest("GET", url, updateRolesList, null)
}


function updateRolesList(status, response) {
    const roles = JSON.parse(response)
    let spinner = document.querySelector(".spinner")
    spinner.classList.add("d-none")
    spinner.classList.remove("d-flex")
    if (roles === "") {
        alert("There is no match!")
    } else {
        roles_list.innerHTML = roles
        addRolesListener()
        addRowsLinks()
    }
}
