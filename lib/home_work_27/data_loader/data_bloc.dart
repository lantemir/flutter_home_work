import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_event.dart';
import 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(const DataInitial()) {
    on<LoadData>(_load);
    on<RetryLoad>(_load);
  }

  Future<void> _load(DataEvent event, Emitter<DataState> emit) async {
    emit(const DataLoading());
    await Future<void>.delayed(const Duration(seconds: 1));

    // Симуляция крайних случаев:
    final r = Random().nextInt(4);

    if (r == 0) {
      emit(const DataError('Ошибка загрузки. Проверьте интернет.'));
      return;
    }

    if (r == 1) {
      emit(const DataSuccess([])); // пустой список
      return;
    }

    if (r == 2) {
      emit(
        DataSuccess(
          List.generate(30, (i) => 'Очень длинный текст элемента #$i — ' * 4),
        ),
      );
      return;
    }

    emit(DataSuccess(List.generate(10, (i) => 'Item #$i')));
  }
}
