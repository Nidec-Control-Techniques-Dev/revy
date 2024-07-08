// import 'package:flutter_bloc/flutter_bloc.dart';
// part 'delegation_event_2.dart';
// part 'delegation_state_2.dart';

// class DelegationBloc extends Bloc<DelegationEvent, DelegationState> {
//   DelegationBloc() : super(DelegationState(
//     countryOption: [],
//     stateOption: [],
//     businessModelOption: [],
//     businessCategoryOption: []
//   )) {
//     on<SalesPersonSelected>(_onSalesPersonSelected);
//   }

//   void _onSalesPersonSelected(SalesPersonSelected event, Emitter<DelegationState> emit) {
//     // Fetch the salesperson details
//     // For example:
//     final countryOption = ["Country1", "Country2"];
//     final stateOption = ["State1", "State2"];
//     final businessModelOption = ["Model1", "Model2"];
//     final businessCategoryOption = ["Category1", "Category2"];
    
//     // Update the state with the fetched details
//     emit(state.copyWith(
//       countryOption: countryOption,
//       stateOption: stateOption,
//       businessModelOption: businessModelOption,
//       businessCategoryOption: businessCategoryOption,
//     ));
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'delegation_event_2.dart';
import 'delegation_state_2.dart';

class DelegationBloc extends Bloc<DelegationEvent, DelegationState> {
  final Map<String, Map<String, List<String>>> salespersonDetails = {
    
    //Store salesperson data from initial loading
    'Salesperson 1': {
      'countries': ['Country 1'],
      'states': ['State 1'],
      'businessModels': ['Model 1'],
      'businessCategories': ['Category 1'],
    },
    'Salesperson 2': {
      'countries': ['Country 2'],
      'states': ['State 2'],
      'businessModels': ['Model 2'],
      'businessCategories': ['Category 2'],
    },
    'Salesperson 3': {
      'countries': ['Country 3'],
      'states': ['State 3'],
      'businessModels': ['Model 3'],
      'businessCategories': ['Category 3'],
    },
  };



  DelegationBloc() : super(DelegationState()) {
    // Figure out how to connect 2 supabase
    // Filter data for UUID from supabase
    // Find table representing delegations
    on<LoadSalespersonDetails>((event, emit) {
      final details = salespersonDetails[event.salesperson];
      if (details != null) {
        emit(DelegationState(
          selectedSalesperson: event.salesperson,
          countries: details['countries'] ?? [],
          states: details['states'] ?? [],
          businessModels: details['businessModels'] ?? [],
          businessCategories: details['businessCategories'] ?? [],
          previousCountries: details['countries'] ?? [],
          previousStates: details['states'] ?? [],
          previousBusinessModels: details['businessModels'] ?? [],
          previousBusinessCategories: details['businessCategories'] ?? [],
        ));
      }
    });

    //add on<InitialLoading>

    on<UpdateDetails>((event, emit) {
      emit(state.copyWith(
        countries: event.countries,
        states: event.states,
        businessModels: event.businessModels,
        businessCategories: event.businessCategories,
      ));
    });

    on<ApplyChanges>((event, emit) {
      final selectedSalesperson = state.selectedSalesperson;
      if (selectedSalesperson != null) {
        // Update the salespersonDetails map with the new data
        salespersonDetails[selectedSalesperson] = {
          'countries': state.countries,
          'states': state.states,
          'businessModels': state.businessModels,
          'businessCategories': state.businessCategories,
        };

        // Emit the new state with updated previous values
        emit(state.copyWith(
          previousCountries: state.countries,
          previousStates: state.states,
          previousBusinessModels: state.businessModels,
          previousBusinessCategories: state.businessCategories,
        ));
      }
    });
  }
}
