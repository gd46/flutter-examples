import 'package:flutter/material.dart';

class ExamplesPage extends StatefulWidget {
  const ExamplesPage({Key? key}) : super(key: key);

  @override
  State<ExamplesPage> createState() => _ExamplesPageState();
}

class _ExamplesPageState extends State<ExamplesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView(
        children: [
          Card(
              child: ListTile(
            title: const Text(
              'Counter example',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
            ),
            onTap: () async {
              await Navigator.pushNamed(context, '/counter');
            },
          )),
          Card(
              child: ListTile(
            title: const Text(
              'Webview loading example',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
            ),
            onTap: () async {
              await Navigator.pushNamed(context, '/webview-loading');
            },
          )),
          Card(
              child: ListTile(
            title: const Text(
              'Webview Communication example',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
            ),
            onTap: () async {
              await Navigator.pushNamed(context, '/webview-communication');
            },
          )),
          Card(
            child: ListTile(
              title: const Text(
                'Animated List',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/animated-list');
              },
            ),
          )
        ],
      ),
    );
  }
}
