import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_sample_app/shared/constants/loading_state_constants.dart';

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
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse('https://flutter.dev'),
            ),
            onLoadStart: (controller, uri) {
              setState(() {
                loadingState = LOADING_STATE.loading;
              });
            },
            onLoadStop: (controller, uri) {
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
