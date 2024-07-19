part of 'schedule_bloc.dart';

sealed class ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final String startingAddress;
  final List<dynamic> companyRefs;
  final List<dynamic> availableCompanies;
  final List<dynamic> companyAddresses;
  final List<dynamic> annualSales;
  final List<dynamic> businessModel;
  final List<dynamic> categoryName;
  final List<dynamic> subcategoryName;
  final List<dynamic> contactNumber;
  final List<dynamic> email;
  final List<dynamic> faxNumber;
  

  ScheduleLoaded({
    required this.startingAddress,
    required this.companyRefs,
    required this.availableCompanies,
    required this.companyAddresses,
    required this.annualSales,
    required this.businessModel,
    required this.categoryName,
    required this.subcategoryName,
    required this.contactNumber,
    required this.email,
    required this.faxNumber

    });
}

class ScheduleReset extends ScheduleState {
  final String startingAddress = "";
  final List<dynamic> companyRefs = [];
  final List<dynamic> availableCompanies = [];
  final List<dynamic> companyAddresses = [];
  final List<dynamic> annualSales = [];
  final List<dynamic> businessModel = [];
  final List<dynamic> categoryName = [];
  final List<dynamic> subcategoryName = [];
  final List<dynamic> contactNumber = [];
  final List<dynamic> email = [];
  final List<dynamic> faxNumber = [];
  
  ScheduleReset();
}

class ScheduleInitial extends ScheduleState {}

// class ScheduleData extends ScheduleState {
//   final List<dynamic>? companyRefs;
//   final List<dynamic>? availableCompanies;
//   final List<dynamic>? companyAddresses;
//   final List<dynamic>? annualSales;
//   final List<dynamic>? businessModel;
//   final List<dynamic>? categoryName;
//   final List<dynamic>? subcategoryName;
//   final List<dynamic>? contactNumber;
//   final List<dynamic>? email;
//   final List<dynamic>? faxNumber;
  

//   ScheduleData({
//     required this.companyRefs,
//     required this.availableCompanies,
//     required this.companyAddresses,
//     required this.annualSales,
//     required this.businessModel,
//     required this.categoryName,
//     required this.subcategoryName,
//     required this.contactNumber,
//     required this.email,
//     required this.faxNumber

//     });
// }