part of 'counter_bloc.dart';

@immutable
abstract class CounterState {
  final int counter;

  const CounterState({required this.counter});
}

class CounterUpdated extends CounterState {
  const CounterUpdated({counter}) : super(counter: counter);
}
