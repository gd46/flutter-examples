import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/shared/constants/loading_state_constants.dart';
import 'package:flutter_sample_app/theme/webview_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../shared/extensions/color_extensions.dart';

enum MenuOptions { setTitle, openDialog, sendJson, routeToFeature }

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
                      _controller.runJavascript('Container.openModal()');
                      break;
                    case MenuOptions.sendJson:
                      _controller.runJavascript(
                          'Container.sendJson({"title": "Test"})');
                      break;
                    case MenuOptions.routeToFeature:
                      _controller.runJavascript(
                          'Container.routeToFeature({uri: "/test"})');
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
                          value: MenuOptions.sendJson,
                          child: Text('Send Json')),
                      const PopupMenuItem(
                          value: MenuOptions.routeToFeature,
                          child: Text('Route to Feature'))
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
                  _loadFlutterBridgeFromAssets();
                  _setWebviewStyles();
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

  _loadFlutterBridgeFromAssets() async {
    final flutterBirdge =
        await rootBundle.loadString('assets/flutter-bridge.js');
    await _controller.runJavascript(flutterBirdge);
  }

  _setWebviewStyles() async {
    final String webviewTheme = getWebviewTheme(context);

    await _controller.runJavascript('''
        const style = document.createElement('style');
        style.textContent = `$webviewTheme`;
        document.head.append(style);
    ''');
  }
}
