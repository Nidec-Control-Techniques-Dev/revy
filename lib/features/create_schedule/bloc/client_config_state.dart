part of 'client_config_bloc.dart';

sealed class DataState {
  const DataState();
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<ValueItem> statesOptions;
  final List<ValueItem> businessModelsOptions;
  final List<ValueItem> categoriesOptions;

  const DataLoaded({
    required this.statesOptions,
    required this.businessModelsOptions,
    required this.categoriesOptions,
  });

  DataLoaded copyWith({
    List<ValueItem>? statesOptions,
    List<ValueItem>? businessModelsOptions,
    List<ValueItem>? categoriesOptions,
  }) {
    return DataLoaded(
      statesOptions: statesOptions ?? this.statesOptions,
      businessModelsOptions: businessModelsOptions ?? this.businessModelsOptions,
      categoriesOptions: categoriesOptions ?? this.categoriesOptions,
    );
  }
}

class DataError extends DataState {
  final String message;

  DataError(this.message);
}

class SupabaseInitialized extends DataState {}
