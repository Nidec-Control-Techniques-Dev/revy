// part of 'delegation_bloc_2.dart';

// class DelegationState {
//   final List<String> countryOption;
//   final List<String> stateOption;
//   final List<String> businessModelOption;
//   final List<String> businessCategoryOption;

//   DelegationState(
//     {
//       required this.countryOption,
//       required this.stateOption,
//       required this.businessModelOption,
//       required this.businessCategoryOption,

//     }
//   );
 
//   DelegationState copyWith(
//     {
//       List<String>? countryOption,
//       List<String>?  stateOption,
//       List<String>?  businessModelOption,
//       List<String>?  businessCategoryOption,
//     }
//   ){
//     return DelegationState(
//       countryOption: countryOption ?? this.countryOption,
//       stateOption: stateOption ?? this.stateOption,
//       businessModelOption: businessModelOption ?? this.businessModelOption,
//       businessCategoryOption: businessCategoryOption ?? this.businessCategoryOption,
//     );
//   }
// }
 
import 'package:equatable/equatable.dart';

// add salesperson list (optional)
class DelegationState extends Equatable {
  final String? selectedSalesperson;
  final List<String> countries;
  final List<String> states;
  final List<String> businessModels;
  final List<String> businessCategories;
  final List<String> previousCountries;
  final List<String> previousStates;
  final List<String> previousBusinessModels;
  final List<String> previousBusinessCategories;

  DelegationState({
    this.selectedSalesperson,
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
