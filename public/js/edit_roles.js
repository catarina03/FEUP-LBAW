let roles = document.getElementsByClassName("role-item")
if(roles != null) {
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
    const url = window.location.protocol + "//" +  window.location.host + '/api/administration/roles/'+ person_id + '/edit_role'
    console.log(url)

    request.open('put',  url, true)
    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            console.log(request.status)
            if (request.status === 200) {
                old_role.innerText = new_role
            }
            else {
                alert("something happen")
            }
        }
    }

    request.send(encodeForAjax({new_role : new_role}))
}
