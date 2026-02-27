import 'package:equatable/equatable.dart';

sealed class DataState extends Equatable {
  const DataState();
  @override
  List<Object?> get props => [];
}

class DataInitial extends DataState {
  const DataInitial();
}

class DataLoading extends DataState {
  const DataLoading();
}

class DataSuccess extends DataState {
  final List<String> items;
  const DataSuccess(this.items);

  @override
  List<Object?> get props => [items];
}

class DataError extends DataState {
  final String message;
  const DataError(this.message);

  @override
  List<Object?> get props => [message];
}
