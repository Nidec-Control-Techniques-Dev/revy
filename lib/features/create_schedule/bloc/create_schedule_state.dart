part of 'create_schedule_bloc.dart';


class CreateScheduleState {
  final String startLocation;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> chosenStates;
  final List<String> chosenBusinessModels;
  final List<String> chosenCategories;
  
  CreateScheduleState(
    {
      required this.startLocation,
      required this.startDate,
      required this.endDate,
      required this.chosenStates,
      required this.chosenBusinessModels,
      required this.chosenCategories
    }
  );

  CreateScheduleState copyWith(
    {
      String? startLocation,
      DateTime?  startDate,
      DateTime?  endDate,
      List<String>?  chosenStates,
      List<String>?  chosenBusinessModels,
      List<String>?  chosenCategories,
    }
  ){
    return CreateScheduleState(
      startLocation: startLocation ?? this.startLocation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      chosenStates: chosenStates ?? this.chosenStates,
      chosenBusinessModels: chosenBusinessModels ?? this.chosenBusinessModels,
      chosenCategories: chosenCategories ?? this.chosenCategories,
    );
  }
}


