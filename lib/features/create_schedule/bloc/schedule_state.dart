part of 'schedule_bloc.dart';

sealed class ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<dynamic> availableCompanies;
  final List<dynamic> companyAddresses;
  final List<dynamic> annualSales;
  // List<dynamic> telephoneNumbers
  

  ScheduleLoaded({required this.availableCompanies, required this.companyAddresses, required this.annualSales});
}

class ScheduleInitial extends ScheduleState {}