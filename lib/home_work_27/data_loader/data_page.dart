import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_bloc.dart';
import 'data_event.dart';
import 'data_state.dart';
import 'widgets/data_error.dart';
import 'widgets/data_loading.dart';
import 'widgets/data_success.dart';

class DataLoaderPage extends StatelessWidget {
  const DataLoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DataBloc()..add(const LoadData()),
      child: const _DataLoaderView(),
    );
  }
}

class _DataLoaderView extends StatelessWidget {
  const _DataLoaderView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Загрузка данных')),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          return switch (state) {
            DataInitial() => const SizedBox.shrink(),
            DataLoading() => const DataLoadingView(),
            DataError(:final message) => DataErrorView(
              message: message,
              onRetry: () => context.read<DataBloc>().add(const RetryLoad()),
            ),
            DataSuccess(:final items) => DataSuccessView(
              items: items,
              onRetry: () => context.read<DataBloc>().add(const RetryLoad()),
            ),
          };
        },
      ),
    );
  }
}
