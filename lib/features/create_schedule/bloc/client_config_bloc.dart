// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
// import '../../../env/env.dart';

part 'client_config_event.dart';
part 'client_config_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<InitializeSupabase>(_onInitializeSupabase);
    // on<GenerateSchedule>(onGenerateSchedule);
  }

  Future<void> _onInitializeSupabase(InitializeSupabase event, Emitter<DataState> emit) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithPassword(
        email: 'nidec.ct.dev@gmail.com',
        password: 'Qwerty1234',
      );
      emit(SupabaseInitialized());
      print('Supabase initialized successfully.');
    } catch (e) {
      emit(DataError(e.toString()));
      print('Error initializing Supabase: $e');
      return;
    }

    try {
      print('Fetching states...');
      final statesResponse = await Supabase.instance.client
          .from('states')
          .select('uuid, name')
          .eq('country_ref', '3a55c85a-182a-4d80-854f-a9409631df6b');

      final businessModelsResponse = await Supabase.instance.client
          .from('business_models')
          .select('uuid, name');

      final categoriesResponse = await Supabase.instance.client
          .from('categories')
          .select('uuid, name');
      print('Categories response: $categoriesResponse');

      final statesOptions = (statesResponse as List)
          .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
          .toList();

      final businessModelsOptions = (businessModelsResponse as List)
          .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
          .toList();

      final categoriesOptions = (categoriesResponse as List)
          .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
          .toList();

      emit(DataLoaded(
        statesOptions: statesOptions,
        businessModelsOptions: businessModelsOptions,
        categoriesOptions: categoriesOptions,
      ));
    } catch (e) {
      emit(DataError(e.toString()));
      print('Error fetching data: $e');
    }
  }
}
