part of 'schedule_bloc.dart';

sealed class GenerateSchedule {

  const GenerateSchedule(
      {
      startDate,
      endDate,
      statesOptions,
      businessModelsOptions,
      categoriesOptions
    }
  );
}

final class EmitSchedule extends GenerateSchedule{
  EmitSchedule(
    { super.startDate,
      super.endDate,
      super.statesOptions,
      super.businessModelsOptions,
      super.categoriesOptions
    }
  );
}