import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/shared/constants/loading_state_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MenuOptions { setTitle, openDialog, sendJson }

class WebViewCommunicationExamplePage extends StatefulWidget {
  const WebViewCommunicationExamplePage({Key? key}) : super(key: key);

  @override
  State<WebViewCommunicationExamplePage> createState() =>
      _WebViewCommunicationExamplePageState();
}

class _WebViewCommunicationExamplePageState
    extends State<WebViewCommunicationExamplePage> {
  LOADING_STATE loadingState = LOADING_STATE.loading;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Webview Communication Example'),
          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case MenuOptions.setTitle:
                      _controller
                          .runJavascript('Container.setTitle("From Flutter")');
                      break;
                    case MenuOptions.openDialog:
                      _controller.runJavascript('Container.openDialog()');
                      break;
                    case MenuOptions.sendJson:
                      _controller.runJavascript(
                          'Container.sendJson({"title": "Test"})');
                      break;
                  }
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: MenuOptions.setTitle,
                          child: Text('Set Title')),
                      const PopupMenuItem(
                          value: MenuOptions.openDialog,
                          child: Text('Open Dialog')),
                      const PopupMenuItem(
                          value: MenuOptions.sendJson, child: Text('Send Json'))
                    ])
          ],
        ),
        body: IndexedStack(
          index: loadingState.index,
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
            WebView(
                initialUrl: 'http://localhost:4200/',
                javascriptMode: JavascriptMode.unrestricted,
                javascriptChannels: {
                  JavascriptChannel(
                      name: 'snackBarHandler',
                      onMessageReceived: (JavascriptMessage message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message.message)));
                      }),
                  JavascriptChannel(
                      name: 'dialogHandler',
                      onMessageReceived:
                          (JavascriptMessage javascriptMessage) async {
                        final dialogConfig =
                            jsonDecode(javascriptMessage.message);
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(dialogConfig['title']),
                              );
                            });
                      })
                },
                onPageStarted: (value) {
                  setState(() {
                    loadingState = LOADING_STATE.loading;
                  });
                },
                onPageFinished: (value) {
                  setState(() {
                    loadingState = LOADING_STATE.loadingCompleted;
                  });
                },
                onWebViewCreated: (WebViewController webviewController) {
                  _controller = webviewController;
                }),
          ],
        ),
      ),
    );
  }

  /*
   * If you wanted to load local flutter asset with html and javascript bridge
   */
  _loadHtmlFromAssets() async {
    _controller.loadFlutterAsset('assets/index.html');
  }
}
