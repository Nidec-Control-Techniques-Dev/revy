part of 'get_params_bloc.dart';

sealed class GetParamsEvent {
  final String? filterStatus;
  final DateTime? startDate;
  final DateTime? endDate;

  GetParamsEvent({
    this.filterStatus,
    this.startDate,
    this.endDate,
  });
}

final class FilterStatusChanged extends GetParamsEvent {
  FilterStatusChanged({
    super.filterStatus,
    super.startDate,
    super.endDate,
  });
}

final class DatesChanged extends GetParamsEvent {
  DatesChanged({
    super.filterStatus,
    super.startDate,
    super.endDate,
  });
}
