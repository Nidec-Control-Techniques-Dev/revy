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
  ReadProgressBloc()
      : super(ProgressTrackerState(
          filterStatus: "All",
          startDate: DateTime.now(),
          endDate: DateTime.now(),
        )) {
    on<ApplyButtonPressed>((event, emit) => emit(state.copyWith(
          filterStatus: event.filterStatus,
          startDate: event.startDate,
          endDate: event.endDate,
        )));
  }
}
