import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../counter_cubit.dart';

class CounterActions extends StatelessWidget {
  const CounterActions({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CounterCubit>();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElevatedButton(onPressed: cubit.increment, child: const Text('+1')),
        ElevatedButton(onPressed: cubit.decrement, child: const Text('-1')),
        OutlinedButton(onPressed: cubit.reset, child: const Text('Reset')),
        TextButton(
          onPressed: cubit.clearState,
          child: const Text('Clear state'),
        ),
      ],
    );
  }
}
