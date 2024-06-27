part of 'schedule_bloc.dart';

sealed class ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<dynamic> availableCompanies;
  final List<dynamic> companyAddresses;
  // List<dynamic> telephoneNumbers
  

  ScheduleLoaded({required this.availableCompanies, required this.companyAddresses});
}

class ScheduleInitial extends ScheduleState {}