import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int value;
  final List<String> history; // последние 10 событий

  const CounterState({required this.value, required this.history});

  factory CounterState.initial() => const CounterState(value: 0, history: []);

  CounterState copyWith({int? value, List<String>? history}) {
    return CounterState(
      value: value ?? this.value,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props => [value, history];
}
