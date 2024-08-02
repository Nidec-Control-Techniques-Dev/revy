import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'assigned_salesperson_event.dart';
part 'assigned_salesperson_state.dart';

class AssignedSalespersonBloc extends Bloc<AssignedSalespersonEvent, AssignedSalespersonState>{
  AssignedSalespersonBloc() : super(DataInitial()) {
    on<InitialState>(_emitNextEvent);
    on<LoadData>(_getAssignedUsers);
  }
  Future<void> _emitNextEvent(AssignedSalespersonEvent event, Emitter<AssignedSalespersonState> emit) async{
    print("_emitNextEvent started");
    emit(DataNotLoaded());
    add(LoadData());
  }

  Future<void> _getAssignedUsers(AssignedSalespersonEvent event, Emitter<AssignedSalespersonState> emit) async{

    final supabase = Supabase.instance.client;
    await supabase.auth.signInWithPassword(
      email: 'markbadua92@gmail.com',
      password: 'hiqzu7-wexgor-nijGet',
    );
    print('Supabase initialized successfully.');
    final user = supabase.auth.currentUser;
    // print("user $user" );
    if (user != null){
      String userUid = user.id;
      print("response-------------");
      print("user $userUid" );
      print("response-------------");
      final clientResponse = await supabase.rpc("get_assigned_users_and_names",
        params: {
          // "user_uuid": 'd88fccf4-1c04-4583-be1f-8f9be2601433'
          "user_uuid": userUid
        }
      );

      print("response-------------");
      print("$clientResponse");
      print("response-------------");
      
      final countries = await supabase
      .from("countries")
      .select("uuid, name");

      final businessModels = await supabase
      .from("business_models")
      .select("uuid, name");

      final states = await supabase
      .from("states")
      .select("uuid, name");

      final categories = await supabase
      .from("categories")
      .select("uuid, name");




      List<String> uuidList = clientResponse[0]["assigned_salespeople"].cast<String>();
      List<String> nameList = clientResponse[0]["salespeople_full_names"].cast<String>();

      
      print("response-------------");
      print("$uuidList");
      print("response-------------");

      emit(
        DataLoaded(
          salesPeopleNames: nameList,
          salesPeopleRef: uuidList,
          categories: categories,
          countries: countries,
          businessModels: businessModels,
          states: states
        )
      );
    }
    else{
      emit(
        const DataLoaded(
          salesPeopleNames: [""],
          salesPeopleRef: [""],
          categories: [""],
          countries: [""],
          businessModels: [""],
          states: [""],
        )
      );
  }

}


}
