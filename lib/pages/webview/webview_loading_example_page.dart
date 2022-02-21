import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/shared/constants/loading_state_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLoadingExamplePage extends StatefulWidget {
  const WebViewLoadingExamplePage({Key? key}) : super(key: key);

  @override
  State<WebViewLoadingExamplePage> createState() =>
      _WebViewLoadingExamplePageState();
}

class _WebViewLoadingExamplePageState extends State<WebViewLoadingExamplePage> {
  LOADING_STATE loadingState = LOADING_STATE.loading;

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
        title: const Text('Webview Loading Example'),
      ),
      body: IndexedStack(
        index: loadingState.index,
        children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          WebView(
            initialUrl: 'https://flutter.dev',
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
          )
        ],
      ),
    );
  }
}
