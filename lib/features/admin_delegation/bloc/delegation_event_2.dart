part of 'delegation_bloc_2.dart';

abstract class DelegationEvent extends Equatable {
  const DelegationEvent();
}

// add an event to retrieve salesperson list (initialize at the beginning)
// salesperson should be UUID
class LoadSalespersonDetails extends DelegationEvent {
  final String salesperson; 
  final String salespersonRef;

  const LoadSalespersonDetails(this.salesperson, this.salespersonRef);

  @override
  List<Object> get props => [salesperson];
}

class UpdateDetails extends DelegationEvent {
  final String? salesperson;
  final String? salespersonRef;
  final List<String> countries;
  final List<String> states;
  final List<String> businessModels;
  final List<String> businessCategories;

  const UpdateDetails({
    required this.salesperson,
    required this.salespersonRef,
    required this.countries,
    required this.states,
    required this.businessModels,
    required this.businessCategories,
  });

  @override
  List<Object?> get props => [
        salesperson,
        salespersonRef,
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
