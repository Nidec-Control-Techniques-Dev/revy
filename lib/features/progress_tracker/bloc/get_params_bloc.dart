// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_params_event.dart';
part 'get_params_state.dart';

class GetParamsBloc extends Bloc<GetParamsEvent, GetParamsState> {
  GetParamsBloc()
      : super(GetParamsState(
          filterStatus: "",
          startDate: DateTime.now(),
          endDate: DateTime.now(),
        )) {
    on<FilterStatusChanged>((event, emit) => emit(state.copyWith(
          filterStatus: event.filterStatus,
          startDate: event.startDate,
          endDate: event.endDate,
        )));

    on<DatesChanged>((event, emit) => emit(state.copyWith(
          filterStatus: event.filterStatus,
          startDate: event.startDate,
          endDate: event.endDate,
        )));
  }
}
