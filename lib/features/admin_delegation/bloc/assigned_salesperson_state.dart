part of 'assigned_salesperson_bloc.dart';

sealed class AssignedSalespersonState {
  const AssignedSalespersonState();
}
class DataInitial extends AssignedSalespersonState{}

class DataNotLoaded extends AssignedSalespersonState{}

class DataLoaded extends AssignedSalespersonState {
  final List<String> salesPeopleNames;
  final List<String> salesPeopleRef;
  final List<dynamic> countries;
  final List<dynamic> businessModels;
  final List<dynamic> states;
  final List<dynamic> categories;
  
  const DataLoaded({
    required this.salesPeopleNames,
    required this.salesPeopleRef,
    required this.countries,
    required this.businessModels,
    required this.states,
    required this.categories,
    
  });

  DataLoaded copyWith({
    List<String>? salesPeopleNames,
    List<String>? salesPeopleRef
  }) {
    return DataLoaded(
      salesPeopleNames: salesPeopleNames ?? this.salesPeopleNames,
      salesPeopleRef: salesPeopleRef ?? this.salesPeopleRef,
      countries: countries,
      businessModels: businessModels,
      states: states,
      categories: categories,
    );
  }
}
