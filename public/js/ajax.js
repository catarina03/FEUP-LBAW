function encodeForAjax(data) {
    if (data == null) return null;
    return Object.keys(data).map(function (k) {
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&')
}



function makeRequest(method, url, f, params){
    const request = new XMLHttpRequest()
    request.onreadystatechange = function(){
        if(request.readyState === XMLHttpRequest.DONE){
            f.call(request.status, request.status, request.responseText)
        }
    }
    request.open(method, url, true)
    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    if(params !== null) request.send(params)
    else request.send()
}
