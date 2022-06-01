import 'package:flutter/material.dart';
import 'package:flutter_sample_app/pages/examples/examples.dart';

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
      child: ListView.builder(
          itemCount: examples.length,
          itemBuilder: (BuildContext context, int index) {
            ExampleCardData _exampleCardData = examples[index];
            return Card(
              child: ListTile(
                title: Text(
                  _exampleCardData.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.headline1!.color),
                ),
                onTap: () async {
                  await Navigator.pushNamed(context, _exampleCardData.route);
                },
              ),
            );
          }),
    );
  }
}
