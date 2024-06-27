part of 'read_progress_bloc.dart';

sealed class ProgressTrackerEvent {
  final String? filterStatus;
  final DateTime? startDate;
  final DateTime? endDate;

  ProgressTrackerEvent({
    this.filterStatus,
    this.startDate,
    this.endDate,
  });
}

final class ApplyButtonPressed extends ProgressTrackerEvent {
  ApplyButtonPressed({
    super.filterStatus,
    super.startDate,
    super.endDate,
  });
}
