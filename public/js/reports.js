let confirm = document.querySelectorAll(".assign-button")
if (confirm != null) {
    for (let i = 0; i < confirm.length; i++)
        confirm[i].addEventListener("click", assign_to_me_modal)
}

let action = document.querySelectorAll(".action-button")
if (action != null) {
    for (let i = 0; i < action.length; i++)
        action[i].addEventListener("click", showReportAction)
}

let rows = document.querySelectorAll(".report-item");
if (rows != null) {
    for (let i = 0; i < rows.length; i++)
        rows[i].addEventListener("click", function(event) {
            event.preventDefault()
            let ev = event.target.closest(".report-row")
            if(ev != null) {
                let h = ev.dataset.href.replaceAll("'", "")
                window.location.href = window.location.protocol + "//" + window.location.host + h
            }
        })
}

let modalConfirm = document.querySelector('.confirm-modal')
let nmodalConfirm = new bootstrap.Modal(modalConfirm, {})

let modalAction = document.querySelector('.report_action')
let nmodalAction = new bootstrap.Modal(modalAction, {})
let error = document.querySelector(".motive-error")

function assign_to_me_modal(event) {
    event.preventDefault()

    let section = event.target.closest(".report-actions-section")
    let id = section.dataset.id
    let type = section.dataset.type

    modalConfirm.dataset.id = id
    modalConfirm.dataset.type = type
    nmodalConfirm.show()

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

    if (status !== 200) {
        alert("Error assigning report")
    }
    else {
        let res = JSON.parse(responseText)
        let view = res['view']
        let id = res['id']
        let type = res['type']

        let el = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"]`)
        el.innerHTML = view

        let action = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"] .action-button`)
        if (action != null) action.addEventListener("click", showReportAction)
    }
}

function showReportAction(event) {
    event.preventDefault();


    let section = event.target.closest(".report-actions-section")
    let id = section.dataset.id
    let type = section.dataset.type

    let el = modalAction.querySelector(".report-motives")
    modalAction.dataset.id = id
    modalAction.dataset.type = type
    el.innerHTML = "Getting all motives..."

    error.classList.remove("d-block")
    error.classList.add("d-none")
    nmodalAction.show()

    const url = window.location.protocol + "//" + window.location.host + '/api/reports/' + id + '/motives'
    makeRequest("POST", url, answerReport, encodeForAjax({content_type: type}))
}

function answerReport(status, responseText) {
    console.log("oi -> " + status + ", " + responseText)
    if (status !== 200) alert("Error getting all report motives")
    else {
        let res = JSON.parse(responseText)
        let view = res['view']
        let id = res['id']
        let type = res['type']

        let el = document.querySelector(`.report_action[data-id="${id}"][data-type="${type}"] .report-motives`)
        el.innerHTML = view

        let report_button = document.querySelector('.report_button')
        if (report_button != null) report_button.addEventListener("click", askReport)

        let dismiss_button = document.querySelector('.dismiss_button')
        if (dismiss_button != null) dismiss_button.addEventListener("click", askReport)
    }
}

function askReport(event) {
    event.preventDefault()
    let el = document.getElementById("selectReportMotive")
    let value = el.options[el.selectedIndex].value

    let accepted = event.target.classList.contains("report_button")
    console.log(accepted)

    if ((value === "Select a motive") && accepted) {
        error.classList.remove("d-none")
        error.classList.add("d-block")
    } else {
        error.classList.remove("d-block")
        error.classList.add("d-none")
        nmodalAction.hide()

        let id = modalAction.dataset.id
        let type = modalAction.dataset.type

        let el = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"]`)
        el.innerHTML = "Pending..."

        const url = window.location.protocol + "//" + window.location.host + '/reports/' + id + '/close'
        makeRequest("PUT", url, handleReportActionResponse, encodeForAjax({content_type: type, accepted: accepted}))
    }
}

function handleReportActionResponse(status, responseText) {
    let res = JSON.parse(responseText)
    let id = res['id']
    let type = res['type']

    if (status !== 200) {
        alert("Error answering all reports") //pass to toast
        let el = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"]`)
        el.innerHTML = res['view']
        let action = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"] .action-button`)
        if (action != null) action.addEventListener("click", showReportAction)
    } else {
        let el = document.querySelector(`.report-actions-section[data-id="${id}"][data-type="${type}"]`)
        let row = el.parentNode
        row.parentNode.removeChild(row)
    }
}

let filter = document.querySelector(".filter_reports")
if(filter != null) filter.addEventListener("click", getReports)

let clear_button = document.querySelector(".clear_button")
if(clear_button != null) clear_button.addEventListener("click", getReports)

function getReports(event) {
    event.preventDefault()
    console.log()
    let clear = event.target.classList.contains("clear_button")

    let filters = {}
    const a = document.querySelector('input[name="assignReport"]:checked')
    if(a != null) filters['assign'] = a.value

    let element = document.getElementById("select-category")
    const category = element.options[element.selectedIndex].value
    if(category !== "") filters['category'] = category

    element = document.getElementById("select-type")
    const type = element.options[element.selectedIndex].value
    if(type !== "") filters['type'] = type

    element = document.getElementById("select-report-content")
    const content_type = element.options[element.selectedIndex].value
    if(content_type !== "") filters['content_type'] = content_type

    if(!clear && Object.entries(filters).length <= 0) {
        alert("you need to choose something!")
    }
    else {
        let element = document.querySelector(".roles-list")
        element.innerHTML = ""
        let spinner = document.querySelector(".spinner")
        spinner.classList.remove("d-none")
        spinner.classList.add("d-flex")

        const url = window.location.protocol + "//" + window.location.host + '/moderator/reports/filters?' + encodeForAjax(filters)

        makeRequest("get", url, handleFiltersResponse, null)
    }
}

function handleFiltersResponse(status, response_text) {
    const res = JSON.parse(response_text)

    let element = document.querySelector(".roles-list")
    element.innerHTML = res

    let spinner = document.querySelector(".spinner")
    spinner.classList.add("d-none")
    spinner.classList.remove("d-flex")
}


