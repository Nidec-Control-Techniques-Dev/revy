part of 'upload_schedule_bloc.dart';

sealed class UploadScheduleEvent {
  final List<String> scheduleDates;
  final String startingAddress;
  final List<dynamic> companyRefs;
  final List<dynamic> availableCompanies;
  final List<dynamic> companyAddresses;
  final List<dynamic> annualSales;
  final List<dynamic> businessModel;
  final List<dynamic>categoryName;
  final List<dynamic>subcategoryName;
  final List<dynamic>contactNumber;
  final List<dynamic>email;
  final List<dynamic> faxNumber;

  const UploadScheduleEvent({
    required this.scheduleDates,
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
    required this.faxNumber,
  });
}

final class SaveSchedule extends UploadScheduleEvent{


  SaveSchedule({
    required super.scheduleDates,
    required super.startingAddress,
    required super.companyRefs,
    required super.availableCompanies,
    required super.companyAddresses,
    required super.annualSales,
    required super.businessModel,
    required super.categoryName,
    required super.subcategoryName,
    required super.contactNumber,
    required super.email,
    required super.faxNumber,
  });
}
final class SavingSchedule extends UploadScheduleEvent{
  SavingSchedule({
    required super.scheduleDates,
    required super.startingAddress,
    required super.companyRefs,
    required super.availableCompanies,
    required super.companyAddresses,
    required super.annualSales,
    required super.businessModel,
    required super.categoryName,
    required super.subcategoryName,
    required super.contactNumber,
    required super.email,
    required super.faxNumber,
  });
}