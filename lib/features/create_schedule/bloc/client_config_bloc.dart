import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

part 'client_config_event.dart';
part 'client_config_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<InitializeSupabase>(_onInitializeSupabase);
  }

  Future<void> _onInitializeSupabase(InitializeSupabase event, Emitter<DataState> emit) async {
    try {
      final supabase = Supabase.instance.client;

      emit(SupabaseInitialized());

      final delegations = await Supabase.instance.client
          .from("delegations")
          .select('country_refs, business_model_refs, category_refs, state_refs')
          .eq('delegated_to_ref', supabase.auth.currentUser?.id as Object)
          .limit(1);

      final statesResponse = await Supabase.instance.client
          .from('states')
          .select('uuid, name')
          .inFilter('country_ref', delegations[0]['country_refs'])
          .inFilter('uuid', delegations[0]['state_refs']);

      final businessModelsResponse = await Supabase.instance.client
          .from('business_models')
          .select('uuid, name')
          .inFilter('uuid', delegations[0]['business_model_refs']);

      final categoriesResponse = await Supabase.instance.client
          .from('categories')
          .select('uuid, name')
          .inFilter('uuid', delegations[0]['category_refs']);

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
    }
  }
}
