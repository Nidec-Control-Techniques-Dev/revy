import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(FilterState(
          salesPersonRef: '',
          selectedFilter1: 'Choose a Filter',
          selectedFilter2: 'Choose a Filter',
          tempSelectedFilter1: 'Choose a Filter',
          tempSelectedFilter2: 'Choose a Filter',
          displayText: '',
          // businessModel: '',
          // subcategory: '',
          // address: '',
          // visitStatus: '',
          // annualSales: 0,
          total: 0,
          visitedCount: 0,
          notVisitedCount: 0,
          ongoingCount: 0,
          dataMap: {},
          clientName: [],
          companyRef: [],
          category: [],
          businessModel: [],
          address: [],
          annualSales: [],
          telephoneNumber: [],
          email: [],
          faxNo: [],
          status: [],
          scheduleDates: [],

        )) {
    on<TempFilter1Changed>((event, emit) {
      emit(state.copyWith(tempSelectedFilter1: event.filter, salesPersonRef: event.salesPersonRef));
    });

    on<TempFilter2Changed>((event, emit) {
      emit(state.copyWith(tempSelectedFilter2: event.filter));
    });

    on<ApplyFilters>(_getStatistics);
  }

  Future<void> _getStatistics(FilterEvent event, Emitter<FilterState> emit) async{
    String selectedFilter1 = state.tempSelectedFilter1;
    String selectedFilter2 = state.tempSelectedFilter2;
    String userUuid = state.salesPersonRef;

    int visitedCount = 0;
    int notVisitedCount = 0;
    int ongoingCount = 0;
    List<dynamic> clientName = [];
    List<dynamic> companyRef = [];
    List<dynamic> category = [];
    List<dynamic> businessModel = [];
    List<dynamic>address = [];
    List<dynamic> annualSales = [];
    List<dynamic> telephoneNumber = [];
    List<dynamic> email = [];
    List<dynamic> faxNo = [];
    List<dynamic>status = [];
    List<dynamic> scheduleDates = [];

    final supabase = Supabase.instance.client;
    // await supabase.auth.signInWithPassword(
    //   email: 'markbadua92@gmail.com',
    //   password: 'hiqzu7-wexgor-nijGet',
    // );

    if (selectedFilter1 != 'Choose a Filter' &&
        selectedFilter2 != 'Choose a Filter') {
      print("if statement");
      switch (selectedFilter2) {
        case 'Today':
          print("Today");

          final stats = await supabase.rpc("count_company_statuses_v2",
            params: {
              "p_user_uid": userUuid,
              "dates_param": getDaysInBetween(DateTime.now(), DateTime.now())
            }
          );
          print("stats-------");
          print(stats);
          print("stats-------");

          visitedCount = stats[0]['visited_count'];
          notVisitedCount = stats[0]['unvisited_count'];
          ongoingCount = stats[0]['ongoing_count'];

          final clientResponse = await supabase.rpc("get_scheduled_info_v2",
            params: {
              "status_arr": ['visited', 'unvisited', 'ongoing'],
              "schedule_date_arr": getDaysInBetween(DateTime.now(), DateTime.now()),
              "user_id": userUuid
            }
          );
          clientName = clientResponse.map((item) => item['company_name']).toList();
          companyRef = clientResponse.map((item) => item['company_ref']).toList();
          category = clientResponse.map((item) => item['business_model_names']).toList();
          businessModel = clientResponse.map((item) => item['category_names']).toList();
          address = clientResponse.map((item) => item['full_text']).toList();
          annualSales = clientResponse.map((item) => item['annual_sales']).toList();
          telephoneNumber = clientResponse.map((item) => item['contact_no']).toList();
          email = clientResponse.map((item) => item['email']).toList();
          faxNo = clientResponse.map((item) => item['fax_number']).toList();
          status = clientResponse.map((item) => item['status']).toList();
          break;
        case 'Last 7 Days':
          print("Last 7 Days");

          final stats = await supabase.rpc("count_company_statuses_v2",
            params: {
              "p_user_uid": userUuid,
              "dates_param": getDaysInBetween(DateTime.now().subtract(const Duration(days: 7)), DateTime.now()),
            }
          );
          print("stats-------");
          print(stats);
          print("stats-------");

          visitedCount = stats[0]['visited_count'];
          notVisitedCount = stats[0]['unvisited_count'];
          ongoingCount = stats[0]['ongoing_count'];

          final clientResponse = await supabase.rpc("get_scheduled_info_v2",
            params: {
              "status_arr": ['visited', 'unvisited', 'ongoing'],
              "schedule_date_arr": getDaysInBetween(DateTime.now().subtract(const Duration(days: 7)), DateTime.now()),
              "user_id": userUuid
            }
          );
          clientName = clientResponse.map((item) => item['company_name']).toList();
          companyRef = clientResponse.map((item) => item['company_ref']).toList();
          category = clientResponse.map((item) => item['business_model_names']).toList();
          businessModel = clientResponse.map((item) => item['category_names']).toList();
          address = clientResponse.map((item) => item['full_text']).toList();
          annualSales = clientResponse.map((item) => item['annual_sales']).toList();
          telephoneNumber = clientResponse.map((item) => item['contact_no']).toList();
          email = clientResponse.map((item) => item['email']).toList();
          faxNo = clientResponse.map((item) => item['fax_number']).toList();
          status = clientResponse.map((item) => item['status']).toList();
          break;
        case 'Last 30 Days':
          print("Last 30 Days");

          final stats = await supabase.rpc("count_company_statuses_v2",
            params: {
              "p_user_uid": userUuid,
              "dates_param": getDaysInBetween(DateTime.now().subtract(const Duration(days: 30)), DateTime.now()),
            }
          );
          print("stats-------");
          print(stats);
          print("stats-------");

          visitedCount = stats[0]['visited_count'];
          notVisitedCount = stats[0]['unvisited_count'];
          ongoingCount = stats[0]['ongoing_count'];

          final clientResponse = await supabase.rpc("get_scheduled_info_v2",
            params: {
              "status_arr": ['visited', 'unvisited', 'ongoing'],
              "schedule_date_arr": getDaysInBetween(DateTime.now().subtract(const Duration(days: 30)), DateTime.now()),
              "user_id": userUuid
            }
          );
          clientName = clientResponse.map((item) => item['company_name']).toList();
          companyRef = clientResponse.map((item) => item['company_ref']).toList();
          category = clientResponse.map((item) => item['business_model_names']).toList();
          businessModel = clientResponse.map((item) => item['category_names']).toList();
          address = clientResponse.map((item) => item['full_text']).toList();
          annualSales = clientResponse.map((item) => item['annual_sales']).toList();
          telephoneNumber = clientResponse.map((item) => item['contact_no']).toList();
          email = clientResponse.map((item) => item['email']).toList();
          faxNo = clientResponse.map((item) => item['fax_number']).toList();
          status = clientResponse.map((item) => item['status']).toList();
          break;
        case 'All':
          print("All");
          final stats = await supabase.rpc("count_company_statuses",
            params: {
              "p_user_uid": userUuid
            }
          );
          print("stats-------");
          print(stats);
          print("stats-------");

          visitedCount = stats[0]['visited_count'];
          notVisitedCount = stats[0]['unvisited_count'];
          ongoingCount = stats[0]['ongoing_count'];

          final clientResponse = await supabase.rpc("get_scheduled_info_v2",
            params: {
              "status_arr": ['visited', 'unvisited', 'ongoing'],
              "schedule_date_arr": getDaysInBetween(DateTime.parse("2024-06-01"), DateTime.now()),
              "user_id": userUuid
            }
          );
          clientName = clientResponse.map((item) => item['company_name']).toList();
          companyRef = clientResponse.map((item) => item['company_ref']).toList();
          category = clientResponse.map((item) => item['business_model_names']).toList();
          businessModel = clientResponse.map((item) => item['category_names']).toList();
          address = clientResponse.map((item) => item['full_text']).toList();
          annualSales = clientResponse.map((item) => item['annual_sales']).toList();
          telephoneNumber = clientResponse.map((item) => item['contact_no']).toList();
          email = clientResponse.map((item) => item['email']).toList();
          faxNo = clientResponse.map((item) => item['fax_number']).toList();
          status = clientResponse.map((item) => item['status']).toList();
          scheduleDates = clientResponse.map((item) => item['schedule_date']).toList();

          break;
      }

      int total = visitedCount + notVisitedCount + ongoingCount;
      print("total--------");
      print(total);
      print("total--------");
      String displayText =
          'Filters applied:\nSales Person: $selectedFilter1\nDate: $selectedFilter2\nVisited: $visitedCount\nNot Visited: $notVisitedCount\nOngoing: $ongoingCount\nTotal: $total';

      Map<String, double> dataMap = {
        'Visited': visitedCount.toDouble(),
        'Not Visited': notVisitedCount.toDouble(),
        // 'Ongoing': ongoingCount.toDouble(),
      };

      emit(state.copyWith(
        selectedFilter1: selectedFilter1,
        selectedFilter2: selectedFilter2,
        displayText: displayText,
        visitedCount: visitedCount,
        notVisitedCount: notVisitedCount,
        ongoingCount: ongoingCount,
        total: total,
        dataMap: dataMap,
        clientName: clientName,
        companyRef: companyRef,
        category: category,
        businessModel: businessModel,
        address: address,
        annualSales: annualSales,
        telephoneNumber: telephoneNumber,
        email: email,
        faxNo: faxNo,
        status: status,
        scheduleDates: scheduleDates,
      ));
    }
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
