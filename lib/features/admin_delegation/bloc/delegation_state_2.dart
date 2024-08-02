part of 'delegation_bloc_2.dart';

class DelegationState extends Equatable {
  final String? selectedSalesperson;
  final String? selectedSalespersonRef;
  final List<String> countries;
  final List<String> states;
  final List<String> businessModels;
  final List<String> businessCategories;
  final List<String> previousCountries;
  final List<String> previousStates;
  final List<String> previousBusinessModels;
  final List<String> previousBusinessCategories;

  const DelegationState({
    this.selectedSalesperson,
    this.selectedSalespersonRef,
    this.countries = const [],
    this.states = const [],
    this.businessModels = const [],
    this.businessCategories = const [],
    this.previousCountries = const [],
    this.previousStates = const [],
    this.previousBusinessModels = const [],
    this.previousBusinessCategories = const [],
  });

  DelegationState copyWith({
    String? selectedSalesperson,
    String? selectedSalespersonRef,
    List<String>? countries,
    List<String>? states,
    List<String>? businessModels,
    List<String>? businessCategories,
    List<String>? previousCountries,
    List<String>? previousStates,
    List<String>? previousBusinessModels,
    List<String>? previousBusinessCategories,
  }) {
    return DelegationState(
      selectedSalesperson: selectedSalesperson ?? this.selectedSalesperson,
      selectedSalespersonRef: selectedSalespersonRef?? this.selectedSalespersonRef,
      countries: countries ?? this.countries,
      states: states ?? this.states,
      businessModels: businessModels ?? this.businessModels,
      businessCategories: businessCategories ?? this.businessCategories,
      previousCountries: previousCountries ?? this.previousCountries,
      previousStates: previousStates ?? this.previousStates,
      previousBusinessModels: previousBusinessModels ?? this.previousBusinessModels,
      previousBusinessCategories: previousBusinessCategories ?? this.previousBusinessCategories,
    );
  }

  @override
  List<Object?> get props => [
        selectedSalesperson,
        selectedSalespersonRef,
        countries,
        states,
        businessModels,
        businessCategories,
        previousCountries,
        previousStates,
        previousBusinessModels,
        previousBusinessCategories,
      ];
}
