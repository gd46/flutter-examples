window.myCustomObj = { callHandler: window.flutter_inappwebview.callHandler }

Container = {
    setTitle(newTitle) {
        document.getElementById("title").innerHTML = newTitle;
        sendBack();
    },
    sendJson(json) {
        document.getElementById("json").innerHTML = json['title'];
        // window.flutter_inappwebview.callHandler('snackBarHandler', json);
    },
    routeToFeature(routeConfig) {
        var customEvent = new CustomEvent('onRouteToFeature')
        customEvent.routeConfig = routeConfig;
        window.dispatchEvent(customEvent);
    },
    openModal() {
        var event = new Event('onOpenModel')
        window.dispatchEvent(event);
    },
    showSnackbar(message) {
        return window.myCustomObj.callHandler('snackBarHandler', message);
    },
    openDialog(dialogConfig) {
        return window.myCustomObj.callHandler('dialogHandler', dialogConfig);
    }
}

function sendBack() {
    Container.showSnackbar('Hello from JS');
}