import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../counter_cubit.dart';
import '../counter_state.dart';

class CounterHistory extends StatelessWidget {
  const CounterHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CounterCubit, CounterState, List<String>>(
      selector: (s) => s.history,
      builder: (_, history) {
        if (history.isEmpty) {
          return const Center(child: Text('History is empty'));
        }

        return ListView.separated(
          itemCount: history.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) => ListTile(dense: true, title: Text(history[i])),
        );
      },
    );
  }
}
