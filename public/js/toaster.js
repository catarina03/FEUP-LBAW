let toaster_basic_obj = new bootstrap.Toast(document.getElementById("liveToast"));
let toaster_basic_node = document.getElementById("liveToast");
function show_toaster(text){
    toaster_basic_node.getElementsByClassName("toast-body")[0].innerText = text;
    toaster_basic_obj.show();
}

// shows all pending toasts
const toastElList = [].slice.call(document.querySelectorAll('.toast-generic-php'))
const toastList = toastElList.map(function (toastEl) {
    return new bootstrap.Toast(toastEl)
})
toastList.forEach((toast) => toast.show())
