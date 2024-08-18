part of 'upload_schedule_bloc.dart';

sealed class UploadScheduleState {}
class ScheduleInitial extends UploadScheduleState {}

class ScheduleSavedState extends UploadScheduleState {}

class ScheduleErrorState extends UploadScheduleState {}

class ScheduleIsSaving extends UploadScheduleState {}