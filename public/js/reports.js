let confirm = document.querySelectorAll(".assign-button")
if (confirm != null) {
    for (let i = 0; i < confirm.length; i++)
        confirm[i].addEventListener("click", assign_to_me_modal)
}

function assign_to_me_modal(event) {
    event.preventDefault()

    let section = event.target.closest(".report-section")
    let id = section.dataset.id
    let type = section.dataset.type

    let modal = document.querySelector('.confirm-modal')
    modal.id = "confirm_" + id + "_" + type

    let nmodal = new bootstrap.Modal(modal, {})
    nmodal.show()

    let confirm_yes = document.querySelector('.confirm-yes')
    if(confirm_yes != null) confirm_yes.addEventListener("click", assign_to_me)


}

function assign_to_me(event) {
    event.preventDefault()
    let section = event.target.closest(".confirm-modal")
    let id = section.dataset.id
    let type = section.dataset.type
    console.log(id, type)


    let request = new XMLHttpRequest()
    const url = window.location.protocol + "//" + window.location.host + '/reports/' +  + '/edit_role'
    console.log(url)
    //Route::put('reports/{report_id}/assign_report', 'ReportController@assign');
    request.open('put', url, true)
    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 200) {
                old_role.innerHTML = JSON.parse(this.responseText)
                addRolesListener()
            } else alert("Sorry! There was an error " + request.status)
        }
    }


    let confirm_yes = document.querySelector('.confirm-yes')
    if(confirm_yes != null) confirm_yes.removeEventListener("click", assign_to_me)
}
