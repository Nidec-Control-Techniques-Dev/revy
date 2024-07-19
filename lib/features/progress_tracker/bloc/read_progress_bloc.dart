// ignore_for_file: avoid_print

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

class ReadProgressBloc
    extends Bloc<ProgressTrackerEvent, ProgressTrackerState> {
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

        print('----------------------');
        print(userUid);
        print(uuid.v5(Uuid.NAMESPACE_URL, userUid.toString()));
        print('----------------------');

        final clientResponse = await
            Supabase.instance.client
            .from('scheduled_companies')
            .select('company_ref')
            .eq('user_uid', userUid)
            // .eq('user_uid', uuid.v5(Uuid.NAMESPACE_URL, userUid.toString()))
            .eq('is_scheduled', 1);

        // print('Categories response: $categoriesResponse');
        print('----------------------');
        print("client response:");
        print(clientResponse);
        print('----------------------');
        emit(ProgressTrackerState(
          // clientName: businessModelsResponse, //all the parameters
          clientName: clientResponse, //all the parameters
          businessModel: clientResponse,
          address: clientResponse,
          annualSales: clientResponse,
          telephoneNumber: clientResponse,
          email: clientResponse,
          faxNo: clientResponse,
          status: clientResponse,
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
}
