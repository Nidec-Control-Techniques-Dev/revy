  import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<GenerateSchedule, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<EmitSchedule>(onGenerateSchedule);
  }

  Future<void> onGenerateSchedule(GenerateSchedule event, Emitter<ScheduleState> emit) async {
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithPassword(
        email: 'nidec.ct.dev@gmail.com',
        password: 'Qwerty1234',
      );
      // emit(SupabaseInitialized());
      // print('Supabase initialized successfully.');
      // print("modelsCategoriesFiltered");
      // final modelsCategoriesFiltered = await supabase
      //   .from('company_clients')
      //   .select('company_ref')
      //   .filter('business_model_refs', 'contains', event.);
        // .filter('category_refs', 'contains', event.categoriesOptions?? []);
      // print("stateFiltered");
      final countryFiltered = await supabase
        .from('company_addresses')
        .select('company_ref, full_text')
        .eq('country_ref','3a55c85a-182a-4d80-854f-a9409631df6b');
        // .containedBy('state_ref', event.statesOptions?? []);

      // List<dynamic> companyRefs = stateFiltered.map((item) => item['company_ref']).toList();
      // print("companyNames");
      // final companyNames = await supabase
      //   .from('companies')
      //   .select('uuid, name')
      //   .inFilter('uuid', companyRefs);

      List<dynamic> companyRef = countryFiltered.map((item) => item['company_ref']).toList();
      List<dynamic> companyAddresses = countryFiltered.map((item) => item['full_text']).toList();

      final companyNamesQuery = await supabase
        .from('companies')
        .select('name')
        .inFilter('uuid',companyRef);
      // List<dynamic> availableCompanies = [];
      // emit(ScheduleLoaded(
      //   availableCompanies: availableCompanies
      // ));

      List<dynamic> companyNames = companyNamesQuery.map((item) => item['name']).toList();
      // List<String> companyRefAsString = companyRef.map((item) => item.toString()).toList();
      // String uuids = companyRefAsString.join(','); 
      // String sqlQuery = "SELECT name FROM companies WHERE uuid IN ($uuids)";
      // final response = await supabase.rpc('custom_query', params: {'uuids': uuids}).single().execute();
      emit(ScheduleLoaded(availableCompanies: companyNames.sublist(0,4), companyAddresses:companyAddresses.sublist(0,4)));
  } 
}

