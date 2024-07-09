part of 'upload_schedule_bloc.dart';

// @freezed
// class UploadScheduleEvent with _$UploadScheduleEvent {
//   const factory UploadScheduleEvent.started() = _Started;
// }

sealed class UploadScheduleEvent {}

final class SaveSchedule extends UploadScheduleEvent{
  SaveSchedule();
}
final class SavingSchedule extends UploadScheduleEvent{
  SavingSchedule();
}