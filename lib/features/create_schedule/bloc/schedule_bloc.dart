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
    print("modelsCategoriesFiltered");
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
    print("statesFiltered");
    print(statesFiltered);
    // ignore: avoid_print
    print("---------------");
      
    // final allAvailableCompaniesUuid = await supabase
    //   .from("scheduled_companies")
    //   .select("company_ref")
    //   .filter("company_ref", "in", statesFiltered.map((item) => item['company_ref'] as String).toList())
    //   .eq("is_scheduled", 0);

    // TODO: change allAvailableCompaniesUuid to get data from sql function: get_unscheduled_companies; use rpc
    final allAvailableCompaniesUuid = await supabase.rpc(
      "get_unscheduled_companies",
      params: {
        "refs": statesFiltered.map((item) => item['company_ref'] as String).toList()
      } 
    );

    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print("allAvailableCompaniesUuid");
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

    final chosenClients = await supabase.rpc('clients_v3', params: {
        'lat1': location["lat"],
        'lon1': location["long"],
        'refs': allAvailableCompaniesUuid.map((item) => item['uuid'] as String).toList(),
        'num_rows': (event.endDate.difference(event.startDate).inDays + 1) * 4
      });

    // await supabase
    // .from("scheduled_companies")
    // .insert([
    //     {'company_ref': chosenClients.map((item) => item['company_ref'] as String).toList()[0]},
    //     {'company_ref': chosenClients.map((item) => item['company_ref'] as String).toList()[1]},
    //     {'company_ref': chosenClients.map((item) => item['company_ref'] as String).toList()[2]},
    //     {'company_ref': chosenClients.map((item) => item['company_ref'] as String).toList()[3]}
    //   ]);

    List<Future> futures = [];

    for (var companyId in chosenClients.map((item) => item['company_ref'] as String).toList()){
      futures.add(
        supabase
          .from("scheduled_companies")
          .insert([
              {'company_ref': companyId},
            ])
      );
    }

    await Future.wait(futures);
    
    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print("chosen clients:");
    print(chosenClients);
    // ignore: avoid_print
    print("---------------");

    final chosenClientsInfo = await supabase.rpc("get_client_info_v2",
      params: {
        "company_ref_values": chosenClients.map((item) => item['company_ref'] as String).toList()
      }
    );

    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print("chosenClientsInfo");
    print(chosenClientsInfo);
    // ignore: avoid_print
    print("---------------");

    final availableCompaniesNames = await supabase
      .from("companies")
      .select("name")
      .filter("uuid", "in", chosenClientsInfo.map((item) => item['company_ref'] as String).toList())
      .order("uuid", ascending: true);

    // ignore: avoid_print
    print("---------------");
    // ignore: avoid_print
    print("availableCompaniesNames");
    print(availableCompaniesNames);
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
      scheduleDates: getDaysInBetween(event.startDate, event.endDate),
      startingAddress: event.startLocation,
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

  List<String> getDaysInBetween(DateTime startDate, DateTime endDate) {
    // Convert dates to UTC to avoid DST issues
    // DateTime startDateInUTC = DateTime.utc(startDate.year, startDate.month, startDate.day);
    // DateTime endDateInUTC = DateTime.utc(endDate.year, endDate.month, endDate.day);

    // Initialize the list to hold the dates
    List<String> days = [];

    // Loop from startDate to endDate, incrementing by one day
    for (DateTime current = startDate;
        current.isBefore(endDate) || current.isAtSameMomentAs(endDate);
        current = current.add(const Duration(days: 1))) {
      // Add the current date to the list
      days.add(DateTime(current.year, current.month, current.day).toIso8601String().substring(0, 10));
    }
    print(days);
    return days;
  }



}

