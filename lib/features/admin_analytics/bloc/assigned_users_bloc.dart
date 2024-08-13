// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/math.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'assigned_users_event.dart';
part 'assigned_users_state.dart';



// part 'bloc/assigned_users_bloc.freezed.dart';

// class AssignedUsersBloc extends Bloc<AssignedUsersEvent, AssignedUsersState> {
//   AssignedUsersBloc() : super(_Initial()) {
//     on<AssignedUsersEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

class AssignedUsersBloc extends Bloc<AssignedUsersEvent, UsersData>{
  AssignedUsersBloc() : super(DataInitial()) {
    on<InitialState>(_emitNextEvent);
    on<LoadData>(_getAssignedUsers);
  }
  Future<void> _emitNextEvent(AssignedUsersEvent event, Emitter<UsersData> emit) async{
    print("_emitNextEvent started");
    emit(DataNotLoaded());
    add(LoadData());
  }

  Future<void> _getAssignedUsers(AssignedUsersEvent event, Emitter<UsersData> emit) async{

    final supabase = Supabase.instance.client;
    // await supabase.auth.signInWithPassword(
    //   email: 'markbadua92@gmail.com',
    //   password: 'hiqzu7-wexgor-nijGet',
    // );
    print('Supabase initialized successfully.');
    final user = supabase.auth.currentUser;
    // print("user $user" );
    if (user != null){
      String userUid = user.id;
      print("response-------------");
      print("user $userUid" );
      print("response-------------");
      // final clientResponse = await supabase.rpc("get_assigned_users",
      //   params: {
      //     "user_uuid": 'd88fccf4-1c04-4583-be1f-8f9be2601433'
      //   }
      // );
      final clientResponse = await supabase.rpc("get_assigned_users_and_names",
        params: {
          // "user_uuid": 'd88fccf4-1c04-4583-be1f-8f9be2601433'
          "user_uuid": userUid
        }
      );
      print("response-------------");
      print("$clientResponse");
      print("response-------------");
      
      List<String> uuidList = clientResponse[0]["assigned_salespeople"].cast<String>();
      List<String> nameList = clientResponse[0]["salespeople_full_names"].cast<String>();

      
      print("response-------------");
      print("$uuidList");
      print("response-------------");

      emit(
        DataLoaded(
          salesPeopleNames: nameList,
          salesPeopleRef: uuidList
        )
      );
    }
    else{
      emit(
        DataLoaded(
          salesPeopleNames: ["Hello"],
          salesPeopleRef: ["World"]
        )
      );
  }

}


}