function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&')
}


function addLoadSpinner(parent){
    let outterDiv = document.createElement('div')
    outterDiv.classList = "d-flex justify-content-center"
    let spinnerDiv = document.createElement('div')
    spinnerDiv.classList = "spinner-border spinner-border-sm text-center"
    let spinner = document.createElement('span')
    spinner.classList = "visually-hidden"
    spinner.innerText = "Loading..."

    spinnerDiv.appendChild(spinner)
    outterDiv.appendChild(spinnerDiv)
    parent.appendChild(outterDiv)
    return outterDiv
}



