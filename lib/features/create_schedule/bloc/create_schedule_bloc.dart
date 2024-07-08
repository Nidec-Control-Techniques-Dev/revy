// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_schedule_event.dart';
part 'create_schedule_state.dart';
// part 'create_schedule_bloc.freezed.dart';


class CreateScheduleBloc extends Bloc<CreateScheduleEvent, CreateScheduleState> {
  CreateScheduleBloc() : super(
      CreateScheduleState(
        startLocation: "",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        chosenStates: [],
        chosenBusinessModels: [],
        chosenCategories: [],
      )
  ) {
    on <LocationStageStarted>(
      (event,emit) => emit(state.copyWith(
        startLocation: event.startLocation,
        startDate: event.startDate,
        endDate: event.endDate,
        chosenStates: event.chosenStates,
        chosenBusinessModels: event.chosenBusinessModels,
        chosenCategories: event.chosenCategories,
      )
      )
    );
    on <DateStageStarted>(
      (event,emit) => emit(state.copyWith(
        startLocation: event.startLocation,
        startDate: event.startDate,
        endDate: event.endDate,
        chosenStates: event.chosenStates,
        chosenBusinessModels: event.chosenBusinessModels,
        chosenCategories: event.chosenCategories,
      )
      )
    );
    on <ClientConfigStageStarted>(
      (event,emit) => emit(state.copyWith(
        startLocation: event.startLocation,
        startDate: event.startDate,
        endDate: event.endDate,
        chosenStates: event.chosenStates,
        chosenBusinessModels: event.chosenBusinessModels,
        chosenCategories: event.chosenCategories,
      )
      )
    );
    on <ResultStageStarted>(
      (event,emit) => emit(state.copyWith(
        startLocation: event.startLocation,
        startDate: event.startDate,
        endDate: event.endDate,
        chosenStates: event.chosenStates,
        chosenBusinessModels: event.chosenBusinessModels,
        chosenCategories: event.chosenCategories,
      )
      )
    );
  }
}
