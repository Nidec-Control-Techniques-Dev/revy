part of 'assigned_users_bloc.dart';

// @freezed
// class AssignedUsersEvent with _$AssignedUsersEvent {
//   const factory AssignedUsersEvent.started() = _Started;
// }

sealed class AssignedUsersEvent{
}

class InitialState extends AssignedUsersEvent{}

class LoadData extends AssignedUsersEvent{}