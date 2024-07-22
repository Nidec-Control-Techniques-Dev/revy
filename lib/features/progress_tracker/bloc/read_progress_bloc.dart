// ignore_for_file: avoid_print

// import 'dart:ffi';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
part 'read_progress_state.dart';
part 'read_progress_event.dart';


// import 'package:equatable/equatable.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'create_schedule_event.dart';
// part 'create_schedule_state.dart';
// part 'create_schedule_bloc.freezed.dart';

class ReadProgressBloc extends Bloc<ProgressTrackerEvent, ProgressTrackerState> {
  ReadProgressBloc() : super(ProgressTrackerState(
            // filterStatus: "All",
            // startDate: DateTime.now(),
            // endDate: DateTime.now(),
            )) {
    // on<ApplyButtonPressed>((event, emit) => emit(state.copyWith(
    //       filterStatus: event.filterStatus,
    //       startDate: event.startDate,
    //       endDate: event.endDate,
    //     )));
    on<ApplyButtonPressed>(_onInitializeSupabase);
  }

  Future<void> _onInitializeSupabase(
      ApplyButtonPressed event, Emitter<ProgressTrackerState> emit) async {
    // event.filterStatus;
    try {
      var uuid = const Uuid();
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithPassword(
        email: 'nidec.ct.dev@gmail.com',
        password: 'Qwerty1234',
      );
      print('Supabase initialized successfully.');
      final user = supabase.auth.currentUser;

      if (user != null){
        String userUid = user.id;
        // print(user);

        // print('Fetching states...');
        // final statesResponse = await Supabase.instance.client
        //     .from('states')
        //     .select('uuid, name')
        //     .eq('country_ref', '3a55c85a-182a-4d80-854f-a9409631df6b');

        // final businessModelsResponse = await Supabase.instance.client
        //     .from('business_models')
        //     .select('uuid, name');

        // final categoriesResponse = await Supabase.instance.client
        //     .from('categories')
        //     .select('uuid, name');

        // print('----------------------');
        // print(userUid);
        // print(uuid.v5(Uuid.NAMESPACE_URL, userUid.toString()));
        // print('----------------------');

        // final clientResponse = await
        //     Supabase.instance.client
        //     .from('scheduled_companies')
        //     .select('company_ref')
        //     .eq('user_uid', userUid)
        //     // .eq('user_uid', uuid.v5(Uuid.NAMESPACE_URL, userUid.toString()))
        //     .eq('is_scheduled', 1);

        final clientResponse = await supabase.rpc("get_scheduled_info_v2",
          params: {
            "status_arr": event.filterStatus,
            "schedule_date_arr": getDaysInBetween(event.startDate, event.endDate),
            "user_id": userUid
          }
        );
        // print('Categories response: $categoriesResponse');
        print('----------------------');
        print("client response:");
        print(clientResponse);
        print('----------------------');
        print("done");
        emit(ProgressTrackerState(
          // clientName: businessModelsResponse, //all the parameters
          clientName: clientResponse.map((item) => item['company_name']).toList(), //all the parameters
          companyRef: clientResponse.map((item) => item['company_ref']).toList(), //all the parameters
          businessModel: clientResponse.map((item) => item['business_model_names']).toList(),
          category: clientResponse.map((item) => item['category_names']).toList(),
          address: clientResponse.map((item) => item['full_text']).toList(),
          annualSales: clientResponse.map((item) => item['annual_sales']).toList(),
          telephoneNumber: clientResponse.map((item) => item['contact_no']).toList(),
          email: clientResponse.map((item) => item['email']).toList(),
          faxNo: clientResponse.map((item) => item['fax_number']).toList(),
          status: clientResponse.map((item) => item['status']).toList(),
          scheduleDates: clientResponse.map((item) => item['schedule_date']).toList()
          // statesOptions: statesOptions,
          // businessModelsOptions: businessModelsOptions,
          // categoriesOptions: categoriesOptions,
        ));
      }
    } 
    catch (e) {
      emit(DataError(e.toString()));
      print('Error: $e');
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


