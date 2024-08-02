part of 'assigned_salesperson_bloc.dart';

sealed class AssignedSalespersonEvent{
}

class InitialState extends AssignedSalespersonEvent{}

class LoadData extends AssignedSalespersonEvent{}