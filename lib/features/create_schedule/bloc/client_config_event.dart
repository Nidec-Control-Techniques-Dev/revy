part of 'client_config_bloc.dart';

sealed class DataEvent{
  const DataEvent(
      {
      this.statesOptions,
      this.businessModelsOptions,
      this.categoriesOptions
    }
  );

  final List<String>? statesOptions;
  final List<String>? businessModelsOptions;
  final List<String>? categoriesOptions;
}

class FetchData extends DataEvent {}

class InitializeSupabase extends DataEvent {}
