  // import 'package:bloc/bloc.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../../create_schedule/data/datasources/remote/geocode_data_source.dart';
import 'package:dio/dio.dart';
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

      final modelsCategoriesFiltered = await supabase
        .from('company_clients')
        .select('company_ref')
        .containedBy('category_refs', event.chosenCategories.cast<Object>())
        .containedBy('business_model_refs', event.chosenBusinessModels.cast<Object>());

      print("---------------");
      print(modelsCategoriesFiltered);
      print("---------------");

      final statesFiltered = await supabase
      .from("company_addresses")
      .select('company_ref')
      .filter('company_ref', 'in', modelsCategoriesFiltered.map((item) => item['company_ref'] as String).toList())
      .filter('state_ref', 'in', event.chosenStates);

      print("---------------");
      print(statesFiltered);
      print("---------------");
      
      final allAvailableCompaniesUuid = await supabase
      .from("scheduled_companies")
      .select("company_ref")
      .filter("company_ref", "in", statesFiltered.map((item) => item['company_ref'] as String).toList())
      .eq("is_scheduled", 0);


      print("---------------");
      print(allAvailableCompaniesUuid);
      print("---------------");

      final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
      Map<String, dynamic> location = await dataSource.geocodeAddress(event.startLocation);

      print("---------------");
      print("Starting Location Coordinates $location");
      print("---------------");

      final response = await supabase.rpc('clients', params: {
        'lat1': location["lat"],
        'lon1': location["long"],
        'refs': allAvailableCompaniesUuid.map((item) => item['company_ref'] as String).toList(),
      });

      print("---------------");
      print(response);
      print("---------------");

      // final nearestAvailableCompaniesUuid = await supabase
      // .from

      final availableCompaniesNames = await supabase
      .from("companies")
      .select("name")
      .filter("uuid", "in", response.map((item) => item['company_ref'] as String).toList());

      print("---------------");
      print(availableCompaniesNames);
      print("---------------");

      // List<dynamic> companyRefs = stateFiltered.map((item) => item['company_ref']).toList();
      // print("companyNames");
      // final companyNames = await supabase
      //   .from('companies')
      //   .select('uuid, name')
      //   .inFilter('uuid', companyRefs);

      // final countryFiltered = await supabase
      //   .from('company_addresses')
      //   .select('company_ref, full_text')
      //   .eq('country_ref','3a55c85a-182a-4d80-854f-a9409631df6b');
      
      List<dynamic> companyNames = availableCompaniesNames.map((item) => item['name']).toList();
      List<dynamic> companyAddresses = response.map((item) => item['address_name']).toList();
      List<dynamic> companyAnnualSales = response.map((item) => item['annual_sales']).toList();

      // final companyNamesQuery = await supabase
      //   .from('companies')
      //   .select('name')
      //   .inFilter('uuid',companyRef);
      // List<dynamic> availableCompanies = [];
      // emit(ScheduleLoaded(
      //   availableCompanies: availableCompanies
      // ));

      // List<dynamic> companyNames = companyNamesQuery.map((item) => item['name']).toList();
      // List<String> companyRefAsString = companyRef.map((item) => item.toString()).toList();
      // String uuids = companyRefAsString.join(','); 
      // String sqlQuery = "SELECT name FROM companies WHERE uuid IN ($uuids)";
      // final response = await supabase.rpc('custom_query', params: {'uuids': uuids}).single().execute();
      emit(ScheduleLoaded(availableCompanies: companyNames, companyAddresses:companyAddresses, annualSales: companyAnnualSales));
  }

}

