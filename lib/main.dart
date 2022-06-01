import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/blocs/counter/counter_bloc.dart';
import 'package:flutter_sample_app/pages/animated_list/animated_list_example_page.dart';
import 'package:flutter_sample_app/pages/counter/counter_page.dart';
import 'package:flutter_sample_app/pages/home/home_page.dart';
import 'package:flutter_sample_app/pages/webview/webview_communication_example_page.dart';
import 'package:flutter_sample_app/pages/webview/webview_loading_example_page.dart';
import 'package:flutter_sample_app/shared/constants/route_constants.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (BuildContext context) => CounterBloc())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      routes: {
        Routes.webviewLoading: (BuildContext context) =>
            const WebViewLoadingExamplePage(),
        Routes.webviewCommunication: (BuildContext context) =>
            const WebViewCommunicationExamplePage(),
        Routes.counter: (BuildContext context) => const CounterPage(),
        Routes.animatedList: (BuildContext context) =>
            const AnimatedListExamplePage()
      },
      home: const MyHomePage(),
    );
  }
}
