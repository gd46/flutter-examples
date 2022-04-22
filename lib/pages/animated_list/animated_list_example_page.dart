import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedListExamplePage extends StatefulWidget {
  const AnimatedListExamplePage({Key? key}) : super(key: key);

  @override
  State<AnimatedListExamplePage> createState() =>
      _AnimatedListExamplePageState();
}

class _AnimatedListExamplePageState extends State<AnimatedListExamplePage> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  var counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(15);
  late StreamSubscription? counterSub;
  late List<int> data = [2];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counterSub = counterStream.listen((event) {
      setState(() {
        data[0] = event;
      });
      // data.insert(0, event);
      // _key.currentState!.insertItem(event);
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
          _key.currentState!.insertItem(0);
        },
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedList(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  key: _key,
                  initialItemCount: data.length,
                  itemBuilder: (context, index, animation) {
                    // SlideTransition(
                    //     position: Tween<Offset>(
                    //       begin: const Offset(-1, -0.5),
                    //       end: const Offset(0, 0),
                    //     ).animate(animation),
                    return SizeTransition(
                        sizeFactor: animation,
                        key: UniqueKey(),
                        child: Card(
                          child: ListTile(
                              title: Text(
                            'Task ${data[index]}',
                          )),
                        ));
                  },
                )
                // StreamBuilder(
                //   stream: counterStream,
                //   builder: (context, state) {
                //     if (!state.hasData) {
                //       return Container();
                //     }
                //     // return ListView.builder(
                //     //     itemCount: state.data as int,
                //     //     scrollDirection: Axis.vertical,
                //     //     shrinkWrap: true,
                //     //     itemBuilder: (BuildContext context, index) {
                //     //       return Card(
                //     //         child: ListTile(
                //     //             title: Text(
                //     //           'Task ${index}',
                //     //         )),
                //     //       );
                //     //     });
                //     return AnimatedList(
                //       shrinkWrap: true,
                //       scrollDirection: Axis.vertical,
                //       key: _key,
                //       initialItemCount: state.data as int,
                //       itemBuilder: (context, index, animation) {
                //         // SlideTransition(
                //         //     position: Tween<Offset>(
                //         //       begin: const Offset(-1, -0.5),
                //         //       end: const Offset(0, 0),
                //         //     ).animate(animation),
                //         return SizeTransition(
                //             sizeFactor: animation,
                //             key: UniqueKey(),
                //             child: Card(
                //               child: ListTile(
                //                   title: Text(
                //                 'Task ${index}',
                //               )),
                //             ));
                //       },
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
