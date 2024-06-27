part of 'get_params_bloc.dart';

class GetParamsState {
  final String filterStatus;
  final DateTime startDate;
  final DateTime endDate;

  GetParamsState({
    required this.filterStatus,
    required this.startDate,
    required this.endDate,
  });

  GetParamsState copyWith({
    String? filterStatus,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return GetParamsState(
      filterStatus: filterStatus ?? this.filterStatus,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
