let confirm = document.querySelectorAll(".assign-button")
if (confirm != null) {
    for (let i = 0; i < confirm.length; i++)
        confirm[i].addEventListener("click", assign_to_me_modal)
}

let action = document.querySelectorAll(".action-button")
if (action != null) {
    for (let i = 0; i < action.length; i++)
        action[i].addEventListener("click", answerReport)
}

function assign_to_me_modal(event) {
    event.preventDefault()

    let section = event.target.closest(".report-actions-section")
    let id = section.dataset.id
    let type = section.dataset.type

    let modal = document.querySelector('.confirm-modal')
    modal.dataset.id = id
    modal.dataset.type = type

    let nmodal = new bootstrap.Modal(modal, {})
    nmodal.show()

    let confirm_yes = document.querySelector('.confirm-yes')
    if (confirm_yes != null) confirm_yes.addEventListener("click", assign_to_me)
}

function assign_to_me(event) {
    event.preventDefault()
    let section = event.target.closest(".confirm-modal")
    let id = section.dataset.id
    let type = section.dataset.type

    let el = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"]`)
    el.innerHTML = "Pending..."


    const url = window.location.protocol + "//" + window.location.host + '/api/reports/' + id + '/assign_report'
    makeRequest("PUT", url, handleAssignReportResponse, encodeForAjax({content_type: type}))
}

function handleAssignReportResponse(status, responseText) {

    if (status !== 200) alert("Error when assigning report")
    else {
        let res = JSON.parse(responseText)
        let view = res['view']
        let id = res['id']
        let type = res['type']

        let el = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"]`)
        el.innerHTML = view

        let action = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"] .action-button`)
        if (action != null) {
            action.addEventListener("click", answerReport)
        }
    }

}

function answerReport(event) {
    event.preventDefault()
    console.log("hello")
}
