import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedListExamplePage extends StatefulWidget {
  const AnimatedListExamplePage({Key? key}) : super(key: key);

  @override
  State<AnimatedListExamplePage> createState() =>
      _AnimatedListExamplePageState();
}

class _AnimatedListExamplePageState extends State<AnimatedListExamplePage> {
  late GlobalKey<AnimatedListState> _key = GlobalKey();
  // var counterStream =
  //     Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(15);
  var counterSteeam = Stream<List<int>>.fromFuture(
    Future.delayed(const Duration(seconds: 2), () => [1, 2, 3, 4]),
  );
  late StreamSubscription? counterSub;
  late List<int> data = [2];

  @override
  void initState() {
    super.initState();
    counterSub = counterSteeam.listen((event) {
      setState(() {
        data = event;
        _key = GlobalKey();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    counterSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List Example'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          insertItem(0, 1);
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AnimatedList(
                key: _key,
                initialItemCount: data.length,
                itemBuilder: (context, index, animation) =>
                    buildItem(data[index], index, animation),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(int item, int index, Animation<double> animation) =>
      ScaleTransition(
          scale: animation,
          key: UniqueKey(),
          child: Card(
            child: ListTile(
              title: Text('Task $item'),
              onTap: () => removeItem(index),
            ),
          ));

  void insertItem(int index, int item) {
    data.insert(index, item);
    _key.currentState!.insertItem(index);
  }

  void removeItem(int index) {
    final int item = data.removeAt(index);

    _key.currentState!.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}
