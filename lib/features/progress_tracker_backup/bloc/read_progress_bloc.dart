import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bloc/bloc.dart';
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
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithPassword(
        email: 'nidec.ct.dev@gmail.com',
        password: 'Qwerty1234',
      );

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

      emit(ProgressTrackerState(
        clientName: statesResponse, //all the parameters
        businessModel: businessModelsResponse,
        address: categoriesResponse,
        annualSales: categoriesResponse,
        telephoneNumber: statesResponse,
        email: statesResponse,
        faxNo: statesResponse,
        status: businessModelsResponse,
        // statesOptions: statesOptions,
        // businessModelsOptions: businessModelsOptions,
        // categoriesOptions: categoriesOptions,
      ));
    } catch (e) {
      emit(DataError(e.toString()));
      print('Error fetching data: $e');
    }
  }
}
