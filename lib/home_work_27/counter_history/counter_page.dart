import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';
import 'widgets/counter_actions.dart';
import 'widgets/counter_history.dart';
import 'widgets/counter_value.dart';

class CounterHistoryPage extends StatelessWidget {
  const CounterHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const _CounterHistoryView(),
    );
  }
}

class _CounterHistoryView extends StatelessWidget {
  const _CounterHistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cubit: Counter + History')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CounterValue(),
            SizedBox(height: 16),
            CounterActions(),
            SizedBox(height: 16),
            Expanded(child: CounterHistory()),
          ],
        ),
      ),
    );
  }
}
