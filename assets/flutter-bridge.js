Container = {
    setTitle(newTitle) {
        document.getElementById("title").innerHTML = newTitle;
        sendBack();
    },
    sendJson(json) {
        document.getElementById("json").innerHTML = json['title'];
        snackBarHandler.postMessage(json);
    },
    routeToFeature(routeConfig) {
        var customEvent = new CustomEvent('onRouteToFeature')
        customEvent.routeConfig = routeConfig;
        window.dispatchEvent(customEvent);
    },
    openModal() {
        var event = new Event('onOpenModel')
        window.dispatchEvent(event);
    }
}

function sendBack() {
    snackBarHandler.postMessage("Hello from JS");
}