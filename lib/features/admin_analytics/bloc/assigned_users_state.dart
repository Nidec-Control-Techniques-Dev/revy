part of 'assigned_users_bloc.dart';

// @freezed
// class AssignedUsersState with _$AssignedUsersState {
//   const factory AssignedUsersState.initial() = _Initial;
// }
sealed class UsersData {
  const UsersData();
}
class DataInitial extends UsersData{}

class DataNotLoaded extends UsersData{}

class DataLoaded extends UsersData {
  final List<String> salesPeopleNames;
  final List<String> salesPeopleRef;
  
  const DataLoaded({
    required this.salesPeopleNames,
    required this.salesPeopleRef
  });

  DataLoaded copyWith({
    List<String>? salesPeopleNames,
    List<String>? salesPeopleRef
  }) {
    return DataLoaded(
      salesPeopleNames: salesPeopleNames ?? this.salesPeopleNames,
      salesPeopleRef: salesPeopleRef ?? this.salesPeopleRef,
    );
  }
}

// class DataLoaded extends DataState {
//   final List<ValueItem> statesOptions;
//   final List<ValueItem> businessModelsOptions;
//   final List<ValueItem> categoriesOptions;

//   const DataLoaded({
//     required this.statesOptions,
//     required this.businessModelsOptions,
//     required this.categoriesOptions,
//   });

//   DataLoaded copyWith({
//     List<ValueItem>? statesOptions,
//     List<ValueItem>? businessModelsOptions,
//     List<ValueItem>? categoriesOptions,
//   }) {
//     return DataLoaded(
//       statesOptions: statesOptions ?? this.statesOptions,
//       businessModelsOptions: businessModelsOptions ?? this.businessModelsOptions,
//       categoriesOptions: categoriesOptions ?? this.categoriesOptions,
//     );
//   }
// }
