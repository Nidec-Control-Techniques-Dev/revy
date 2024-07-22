import 'package:supabase_flutter/supabase_flutter.dart';

    Future<void> insertSchedule({String? status, String? companyRef}) async{
      final supabase = Supabase.instance.client;
        await supabase.auth.signInWithPassword(
          email: 'nidec.ct.dev@gmail.com',
          password: 'Qwerty1234',
        );
        final user = supabase.auth.currentUser;
        
        if (user != null){
          String userUid = user.id;
          print("user $userUid");
          await supabase
          .from("scheduled_companies")
          .update({"status": status,})
          .eq("company_ref", companyRef as Object)
          ;
          await supabase.rpc("delete_unscheduled_companies");
        }
  }