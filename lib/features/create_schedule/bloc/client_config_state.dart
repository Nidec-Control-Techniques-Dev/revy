part of 'client_config_bloc.dart';

sealed class DataState  {
  const DataState();

}

class DataInitial extends DataState {}

class DataLoading extends DataState {}


class DataLoaded extends DataState {

  final List<String> statesOptions;
  final List<String> businessModelsOptions;
  final List<String> categoriesOptions;

  const DataLoaded({required this.statesOptions, required this.businessModelsOptions, required this.categoriesOptions});

  DataLoaded copyWith(
    {
      final List<String>? statesOptions,
      final List<String>? businessModelsOptions,
      final List<String>? categoriesOptions
    }
  ){
    return DataLoaded(
      statesOptions: statesOptions ?? this.statesOptions,
      businessModelsOptions: businessModelsOptions ?? this.businessModelsOptions,
      categoriesOptions: categoriesOptions ?? this.categoriesOptions
    );
  }
}

class DataError extends DataState {
  final String message;

  DataError(this.message);
}

class SupabaseInitialized extends DataState {}


// abstract class DataState {}

// class DataInitial extends DataState {}
// class DataLoaded extends DataState {
//   final List<String> states;
//   final List<String> businessModels;
//   final List<String> categories;

//   DataLoaded({
//     required this.states,
//     required this.businessModels,
//     required this.categories,
//   });
// }