import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/blocs/counter/counter_bloc.dart';
import 'package:flutter_sample_app/notifiers/app_settings_notifier.dart';
import 'package:flutter_sample_app/pages/animated_list/animated_list_example_page.dart';
import 'package:flutter_sample_app/pages/counter/counter_page.dart';
import 'package:flutter_sample_app/pages/home/home_page.dart';
import 'package:flutter_sample_app/pages/webview/webview_communication_example_page.dart';
import 'package:flutter_sample_app/pages/webview/webview_loading_example_page.dart';
import 'package:flutter_sample_app/shared/constants/route_constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    BlocProvider(create: (BuildContext context) => CounterBloc()),
    ChangeNotifierProvider(
      create: (BuildContext context) => AppSettingsNotifier(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppSettingsNotifier? appSettingsNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appSettingsNotifier = Provider.of<AppSettingsNotifier>(context);
    setCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: appSettingsNotifier?.isDarkModeEnabled == true
          ? ThemeMode.dark
          : ThemeMode.light,
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

  void setCurrentAppTheme() async {
    appSettingsNotifier!.isDarkModeEnabled =
        await appSettingsNotifier!.appSettings.getTheme();
  }
}
