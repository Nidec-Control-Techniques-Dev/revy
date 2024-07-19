part of 'schedule_bloc.dart';

sealed class GenerateSchedule {

  final String startLocation;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> chosenStates;
  final List<String> chosenBusinessModels;
  final List<String> chosenCategories;
  final List<dynamic>? companyRefs;
  final List<dynamic>? availableCompanies;
  final List<dynamic>? companyAddresses;
  final List<dynamic>? annualSales;
  final List<dynamic>? businessModel;
  final List<dynamic>? categoryName;
  final List<dynamic>? subcategoryName;
  final List<dynamic>? contactNumber;
  final List<dynamic>? email;
  final List<dynamic>? faxNumber;

  const GenerateSchedule(
      {
      required this.startLocation,
      required this.startDate,
      required this.endDate,
      required this.chosenStates,
      required this.chosenBusinessModels,
      required this.chosenCategories,
      this.companyRefs,
      this.availableCompanies,
      this.companyAddresses,
      this.annualSales,
      this.businessModel,
      this.categoryName,
      this.subcategoryName,
      this.contactNumber,
      this.email,
      this.faxNumber
      
    }
  );
}

final class EmitSchedule extends GenerateSchedule{
  EmitSchedule(
    {
      required super.startLocation,
      required super.startDate,
      required super.endDate,
      required super.chosenStates,
      required super.chosenBusinessModels,
      required super.chosenCategories
    }
  );
}

final class ResetSchedule extends GenerateSchedule{
  ResetSchedule({required super.startLocation, required super.startDate, required super.endDate, required super.chosenStates, required super.chosenBusinessModels, required super.chosenCategories});
}
