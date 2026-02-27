import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState.initial());

  void increment() => _apply(delta: 1, label: 'Increment (+1)');
  void decrement() => _apply(delta: -1, label: 'Decrement (-1)');

  void reset() {
    emit(state.copyWith(value: 0, history: _pushHistory('Reset (0)')));
  }

  void clearState() {
    emit(CounterState.initial());
  }

  void _apply({required int delta, required String label}) {
    final nextValue = state.value + delta;
    emit(
      state.copyWith(
        value: nextValue,
        history: _pushHistory('$label -> $nextValue'),
      ),
    );
  }

  List<String> _pushHistory(String event) {
    final next = <String>[event, ...state.history];
    return next.length > 10 ? next.sublist(0, 10) : next;
  }
}
