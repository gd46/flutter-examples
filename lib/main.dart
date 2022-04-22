import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/blocs/counter/counter_bloc.dart';
import 'package:flutter_sample_app/pages/animated_list/animated_list_example_page.dart';
import 'package:flutter_sample_app/pages/counter/counter_page.dart';
import 'package:flutter_sample_app/pages/home/home_page.dart';
import 'package:flutter_sample_app/pages/webview/webview_communication_example_page.dart';
import 'package:flutter_sample_app/pages/webview/webview_loading_example_page.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/webview-loading': (BuildContext context) =>
            const WebViewLoadingExamplePage(),
        '/webview-communication': (BuildContext context) =>
            const WebViewCommunicationExamplePage(),
        '/counter': (BuildContext context) => const CounterPage(),
        '/animated-list': (BuildContext context) =>
            const AnimatedListExamplePage()
      },
      home: const MyHomePage(),
    );
  }
}
