part of 'schedule_bloc.dart';

sealed class GenerateSchedule {

  final String startLocation;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> chosenStates;
  final List<String> chosenBusinessModels;
  final List<String> chosenCategories;

  const GenerateSchedule(
      {
      required this.startLocation,
      required this.startDate,
      required this.endDate,
      required this.chosenStates,
      required this.chosenBusinessModels,
      required this.chosenCategories
    }
  );
}

final class EmitSchedule extends GenerateSchedule{
  EmitSchedule(
    {
      required super.startLocation,
      required super.startDate,
      required super.endDate,
      required super.chosenStates,
      required super.chosenBusinessModels,
      required super.chosenCategories
    }
  );
}

final class ResetSchedule extends GenerateSchedule{
  ResetSchedule({required super.startLocation, required super.startDate, required super.endDate, required super.chosenStates, required super.chosenBusinessModels, required super.chosenCategories});
}