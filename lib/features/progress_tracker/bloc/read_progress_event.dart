part of 'read_progress_bloc.dart';

sealed class ProgressTrackerEvent {
  final List<String> filterStatus;
  final DateTime startDate;
  final DateTime endDate;

  ProgressTrackerEvent({
    required this.filterStatus,
    required this.startDate,
    required this.endDate,
  });
}

final class ApplyButtonPressed extends ProgressTrackerEvent {
  ApplyButtonPressed({
    required super.filterStatus,
    required super.startDate,
    required super.endDate,
  });
}
