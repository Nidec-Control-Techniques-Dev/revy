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
    on<ResetSchedule>((event, emit) {
      emit(ScheduleReset());
    });
    // on<SaveSched>((event, emit){
    //   emit(ScheduleData(
    //     companyRefs: event.companyRefs,
    //     availableCompanies: event.availableCompanies,
    //     companyAddresses: event.companyAddresses,
    //     annualSales: event.annualSales,
    //     businessModel: event.businessModel,
    //     categoryName: event.categoryName, 
    //     subcategoryName: event.subcategoryName, 
    //     contactNumber: event.contactNumber, 
    //     email: event.email, 
    //     faxNumber: event.faxNumber
    //     ));
    // });
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
    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print(modelsCategoriesFiltered);
    // ignore: avoid_print
    print("---------------");

    final statesFiltered = await supabase
      .from("company_addresses")
      .select('company_ref')
      .filter('company_ref', 'in', modelsCategoriesFiltered.map((item) => item['company_ref'] as String).toList())
      .filter('state_ref', 'in', event.chosenStates);

    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print(statesFiltered);
    // ignore: avoid_print
    print("---------------");
      
    final allAvailableCompaniesUuid = await supabase
      .from("scheduled_companies")
      .select("company_ref")
      .filter("company_ref", "in", statesFiltered.map((item) => item['company_ref'] as String).toList())
      .eq("is_scheduled", 0);

    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print(allAvailableCompaniesUuid);
    // ignore: avoid_print
    print("---------------");

    final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
    Map<String, dynamic> location = await dataSource.geocodeAddress(event.startLocation);

    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print("Starting Location Coordinates $location");
    // ignore: avoid_print
    print("---------------");

    final chosenClients = await supabase.rpc('clients', params: {
        'lat1': location["lat"],
        'lon1': location["long"],
        'refs': allAvailableCompaniesUuid.map((item) => item['company_ref'] as String).toList(),
      });

    List<Future> futures = [];

    for (var companyId in chosenClients.map((item) => item['company_ref'] as String).toList()){
      futures.add(
        supabase
          .from("scheduled_companies")
          .update({"is_chosen": 1})
          .eq("company_ref", companyId)
      );
    }

    await Future.wait(futures);
    
    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print(chosenClients);
    // ignore: avoid_print
    print("---------------");

    final availableCompaniesNames = await supabase
      .from("companies")
      .select("name")
      .filter("uuid", "in", chosenClients.map((item) => item['company_ref'] as String).toList())
      .order("uuid", ascending: true);

    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print(availableCompaniesNames);
    // ignore: avoid_print
    print("---------------");

    final chosenClientsInfo = await supabase.rpc("get_client_info",
      params: {
        "company_ref_values": chosenClients.map((item) => item['company_ref'] as String).toList()
      }
    );

    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print(chosenClientsInfo);
    // ignore: avoid_print
    print("---------------");

    List<dynamic> businessModel = chosenClientsInfo.map((item) => item['business_model_names']).toList();
    List<dynamic> categoryName = chosenClientsInfo.map((item) => item['category_names']).toList();
    List<dynamic> subcategoryName = chosenClientsInfo.map((item) => item['subcategory_names']).toList();
    List<dynamic> contactNumber = chosenClientsInfo.map((item) => item['contact_number']).toList();
    List<dynamic> email = chosenClientsInfo.map((item) => item['email']).toList();
    List<dynamic> faxNumber = chosenClientsInfo.map((item) => item['fax_number']).toList();
    List<dynamic> companyNames = availableCompaniesNames.map((item) => item['name']).toList();
    List<dynamic> companyAddresses = chosenClients.map((item) => item['address_name']).toList();
    List<dynamic> companyAnnualSales = chosenClients.map((item) => item['annual_sales']).toList();

    emit(ScheduleLoaded(
      companyRefs: chosenClients.map((item) => item['company_ref'] as String).toList(),
      availableCompanies: companyNames, 
      companyAddresses:companyAddresses,
      annualSales: companyAnnualSales,
      businessModel: businessModel,
      categoryName: categoryName,
      subcategoryName: subcategoryName,
      contactNumber: contactNumber,
      email: email,
      faxNumber: faxNumber
      )
    );
  }

}

