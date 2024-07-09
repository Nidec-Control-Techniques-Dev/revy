import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_schedule_event.dart';
part 'upload_schedule_state.dart';
// part 'bloc/upload_schedule_bloc.freezed.dart';

class UploadScheduleBloc extends Bloc<UploadScheduleEvent, UploadScheduleState> {
  UploadScheduleBloc() : super(ScheduleInitial()) {
    on<SaveSchedule>(_triggerSavingSchedule);
    on<SavingSchedule>(insertSchedule);
  }

  void _triggerSavingSchedule(UploadScheduleEvent event, Emitter<UploadScheduleState> emit) {
      // Some logic
      // Trigger another event
      emit(ScheduleIsSaving());
      add(SavingSchedule());
  }
    Future<void> insertSchedule(UploadScheduleEvent event, Emitter<UploadScheduleState> emit) async{
      await Future.delayed(const Duration(seconds: 5));
      emit(ScheduleSavedState());
  }
}
