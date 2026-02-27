import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../counter_cubit.dart';
import '../counter_state.dart';

class CounterValue extends StatelessWidget {
  const CounterValue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CounterCubit, CounterState, int>(
      selector: (s) => s.value,
      builder: (_, value) {
        return Text(
          'Value: $value',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
