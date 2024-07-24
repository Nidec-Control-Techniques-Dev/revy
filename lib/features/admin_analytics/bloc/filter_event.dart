part of 'filter_bloc.dart';

abstract class FilterEvent {}

class TempFilter1Changed extends FilterEvent {
  final String filter;
  final String salesPersonRef;
  TempFilter1Changed(this.filter, this.salesPersonRef);
}

class TempFilter2Changed extends FilterEvent {
  final String filter;
  TempFilter2Changed(this.filter);
}

// class ApplyFilters extends FilterEvent {
//   final String salesPersonName;
//   final String salesPersonRef;
//   ApplyFilters(this.salesPersonName, this.salesPersonRef);
// }

class ApplyFilters extends FilterEvent {}
