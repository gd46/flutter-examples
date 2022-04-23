import 'package:flutter_sample_app/shared/constants/route_constants.dart';

class ExampleCardData {
  final String title;
  final String route;

  const ExampleCardData({required this.title, required this.route});
}

final List<ExampleCardData> examples = [
  ExampleCardData(title: 'Counter Example', route: Routes.counter),
  ExampleCardData(
      title: 'Webview Loading Example', route: Routes.webviewLoading),
  ExampleCardData(
      title: 'Webview Communication Examples',
      route: Routes.webviewCommunication),
  ExampleCardData(title: 'Animated List', route: Routes.animatedList)
];
