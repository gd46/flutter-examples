import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/blocs/counter/counter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPage();
}

class _CounterPage extends State<CounterPage> {
  late CounterBloc _counterBloc;

  void _incrementCounter() {
    context.read<CounterBloc>().add(IncrementCountEvent());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _counterBloc = context.watch<CounterBloc>();
    // print(_counterBloc.state);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _counterBloc = context.read<CounterBloc>();
    print(_counterBloc.state);
    /*
     *  Putting this here with read will only emit once.
     *  Adding here with watch will get each state change
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Example'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment
                    .center, // use spaceBetween here to push text and count to opposite ends
                children: [
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                      return Text(
                        state.counter.toString(),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      );
                    },
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(DecreaseCountEvent());
                  },
                  child: const Text('Decrease Counter'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
