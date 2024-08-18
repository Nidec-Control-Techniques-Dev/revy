import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

    final modelsCategoriesFiltered = await supabase
      .from('company_clients')
      .select('company_ref')
      .containedBy('category_refs', event.chosenCategories.cast<Object>())
      .containedBy('business_model_refs', event.chosenBusinessModels.cast<Object>());

    final statesFiltered = await supabase
      .from("company_addresses")
      .select('company_ref')
      .filter('company_ref', 'in', modelsCategoriesFiltered.map((item) => item['company_ref'] as String).toList())
      .filter('state_ref', 'in', event.chosenStates);

    final allAvailableCompaniesUuid = await supabase.rpc(
      "get_unscheduled_companies",
      params: {
        "refs": statesFiltered.map((item) => item['company_ref'] as String).toList()
      } 
    );

    final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
    Map<String, dynamic> location = await dataSource.geocodeAddress(event.startLocation);

    final chosenClients = await supabase.rpc('clients_v3', params: {
        'lat1': location["lat"],
        'lon1': location["long"],
        'refs': allAvailableCompaniesUuid.map((item) => item['uuid'] as String).toList(),
        'num_rows': (event.endDate.difference(event.startDate).inDays + 1) * 4
      });

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

    final chosenClientsInfo = await supabase.rpc("get_client_info_v2",
      params: {
        "company_ref_values": chosenClients.map((item) => item['company_ref'] as String).toList()
      }
    );

    final availableCompaniesNames = await supabase
      .from("companies")
      .select("name")
      .filter("uuid", "in", chosenClientsInfo.map((item) => item['company_ref'] as String).toList())
      .order("uuid", ascending: true);

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
    List<String> days = [];
    for (DateTime current = startDate;
        current.isBefore(endDate) || current.isAtSameMomentAs(endDate);
        current = current.add(const Duration(days: 1))) {
      days.add(DateTime(current.year, current.month, current.day).toIso8601String().substring(0, 10));
    }
    return days;
  }



}

