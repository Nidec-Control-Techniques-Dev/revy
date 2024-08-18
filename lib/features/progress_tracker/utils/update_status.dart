import 'package:supabase_flutter/supabase_flutter.dart';

    Future<void> insertSchedule({String? status, String? companyRef}) async{
      final supabase = Supabase.instance.client;
        final user = supabase.auth.currentUser;
        
        if (user != null){
          await supabase
          .from("scheduled_companies")
          .update({"status": status,})
          .eq("company_ref", companyRef as Object)
          ;
        }
  }