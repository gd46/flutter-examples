import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sample_app/shared/constants/loading_state_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCommunicationExamplePage extends StatefulWidget {
  const WebViewCommunicationExamplePage({Key? key}) : super(key: key);

  @override
  State<WebViewCommunicationExamplePage> createState() =>
      _WebViewCommunicationExamplePageState();
}

class _WebViewCommunicationExamplePageState
    extends State<WebViewCommunicationExamplePage> {
  late int _selectedIndex = 0;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webview Communication Example'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Center(
            child: Column(
              children: [
                const Text('Some flutter page'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: const Text('Open Webview'))
              ],
            ),
          ),
          WebView(
            initialUrl: 'http://localhost:4200/',
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: {
              JavascriptChannel(
                  name: 'snackBarHandler',
                  onMessageReceived: (JavascriptMessage message) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message.message)));
                  }),
              JavascriptChannel(
                  name: 'navigationHandler',
                  onMessageReceived: (JavascriptMessage javascriptMessage) {
                    if (javascriptMessage.message == 'open') {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    } else if (javascriptMessage.message == 'close') {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }
                  })
            },
            onWebViewCreated: (WebViewController webviewController) {
              _controller = webviewController;
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_upward),
        onPressed: () {
          _controller.runJavascript('Container.setTitle("From Flutter")');
        },
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
