function setTitle(newTitle) {
    document.getElementById("title").innerHTML = newTitle;
    sendBack();
}

function sendBack() {
    snackBarHandler.postMessage("Hello from JS");
}