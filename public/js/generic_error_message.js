let GENERIC_ERROR_MODAL = document.getElementById('empty_comment_warning');
let GENERIC_WARNING = new bootstrap.Modal(GENERIC_ERROR_MODAL);

function show_generic_warning(warning,title=""){
    GENERIC_ERROR_MODAL.getElementsByClassName("modal-title").innerText = title;
    GENERIC_ERROR_MODAL.getElementsByClassName("modal_message").innerText = warning;
    GENERIC_WARNING.show();
}