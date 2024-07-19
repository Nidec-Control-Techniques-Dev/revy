part of 'upload_schedule_bloc.dart';

// @freezed
// class UploadScheduleState with _$UploadScheduleState {
//   const factory UploadScheduleState.initial() = _Initial;
// }

sealed class UploadScheduleState {}
class ScheduleInitial extends UploadScheduleState {}

class ScheduleSavedState extends UploadScheduleState {}

class ScheduleErrorState extends UploadScheduleState {}

class ScheduleIsSaving extends UploadScheduleState {}