part of 'read_progress_bloc.dart';

class ProgressTrackerState {
  final String filterStatus;
  final DateTime startDate;
  final DateTime endDate;

  ProgressTrackerState({
    required this.filterStatus,
    required this.startDate,
    required this.endDate,
  });

  ProgressTrackerState copyWith({
    String? filterStatus,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ProgressTrackerState(
      filterStatus: filterStatus ?? this.filterStatus,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
