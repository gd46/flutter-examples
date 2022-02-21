import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterUpdated(counter: 0)) {
    on<IncrementCountEvent>((event, emit) {
      emit(CounterUpdated(counter: state.counter + 1));
    });

    on<DecreaseCountEvent>((event, emit) {
      emit(CounterUpdated(counter: state.counter - 1));
    });
  }
}
