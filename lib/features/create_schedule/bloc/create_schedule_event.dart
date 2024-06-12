part of 'create_schedule_bloc.dart';

sealed class CreateScheduleEvent {
  final String? startLocation;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? chosenStates;
  final List<String>? chosenBusinessModels;
  final List<String>? chosenCategories;

  CreateScheduleEvent(
    {
      this.startLocation,
      this.startDate,
      this.endDate,
      this.chosenStates,
      this.chosenBusinessModels,
      this.chosenCategories
    }
  );
}

final class LocationStageStarted extends CreateScheduleEvent {
  LocationStageStarted(
    {
      super.startLocation,
      super.startDate,
      super.endDate,
      super.chosenStates,
      super.chosenBusinessModels,
      super.chosenCategories,
    }
  );
}


final class DateStageStarted extends CreateScheduleEvent {
  DateStageStarted(
    {
      super.startLocation,
      super.startDate,
      super.endDate,
      super.chosenStates,
      super.chosenBusinessModels,
      super.chosenCategories,
    }
  );
}

final class ClientConfigStageStarted extends CreateScheduleEvent {
  ClientConfigStageStarted(
    {
      super.startLocation,
      super.startDate,
      super.endDate,
      super.chosenStates,
      super.chosenBusinessModels,
      super.chosenCategories,
    }
  );
}

final class ResultStageStarted extends CreateScheduleEvent {
  ResultStageStarted(
    {
      super.startLocation,
      super.startDate,
      super.endDate,
      super.chosenStates,
      super.chosenBusinessModels,
      super.chosenCategories,
    }
  );
}