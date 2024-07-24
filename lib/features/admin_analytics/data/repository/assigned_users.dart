import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<dynamic>> getAssignedUsers() async{

  final supabase = Supabase.instance.client;
  await supabase.auth.signInWithPassword(
    email: 'markbadua92@gmail.com',
    password: 'hiqzu7-wexgor-nijGet',
  );
  print('Supabase initialized successfully.');
  final user = supabase.auth.currentUser;
  print("user $user" );
  if (user != null){
    String userUid = user.id;
    print("user $userUid" );
    final clientResponse = await supabase.rpc("get_assigned_users",
      params: {
        "user_uuid": userUid
      }
    );
    print("-------------");
    print("$clientResponse");
    print("-------------");
    return clientResponse.map((item) => item['assigned_salespeople']).toList();
  }
  else{
    return [];
  }

}

