import 'package:equatable/equatable.dart';

sealed class DataEvent extends Equatable {
  const DataEvent();
  @override
  List<Object?> get props => [];
}

class LoadData extends DataEvent {
  const LoadData();
}

class RetryLoad extends DataEvent {
  const RetryLoad();
}
