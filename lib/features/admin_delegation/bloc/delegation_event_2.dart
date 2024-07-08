// part of 'delegation_bloc_2.dart';

// sealed class DelegationEvent {

//   DelegationEvent({});
// }

// final class SalesPersonSelected extends DelegationEvent {}

import 'package:equatable/equatable.dart';

abstract class DelegationEvent extends Equatable {
  const DelegationEvent();
}

// add an event to retrieve salesperson list (initialize at the beginning)
// salesperson should be UUID
class LoadSalespersonDetails extends DelegationEvent {
  final String salesperson; 

  LoadSalespersonDetails(this.salesperson);

  @override
  List<Object> get props => [salesperson];
}

class UpdateDetails extends DelegationEvent {
  final String? salesperson;
  final List<String> countries;
  final List<String> states;
  final List<String> businessModels;
  final List<String> businessCategories;

  UpdateDetails({
    this.salesperson,
    required this.countries,
    required this.states,
    required this.businessModels,
    required this.businessCategories,
  });

  @override
  List<Object?> get props => [
        salesperson,
        countries,
        states,
        businessModels,
        businessCategories,
      ];
}

class ApplyChanges extends DelegationEvent {
  @override
  List<Object?> get props => [];
}
