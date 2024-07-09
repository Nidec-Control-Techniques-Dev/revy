part of 'filter_bloc.dart';

abstract class FilterEvent {}

class TempFilter1Changed extends FilterEvent {
  final String filter;
  TempFilter1Changed(this.filter);
}

class TempFilter2Changed extends FilterEvent {
  final String filter;
  TempFilter2Changed(this.filter);
}

class ApplyFilters extends FilterEvent {}
