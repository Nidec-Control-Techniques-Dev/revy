import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'update_status_event.dart';
part 'update_status_state.dart';

class UpdateStatusBloc extends Bloc<UpdateStatusEvent, StatusUpdated> {
  UpdateStatusBloc(): super(
    StatusUpdated()
  ) {
    on<ApplyButtonPressed>(insertSchedule);
  }

  void _triggerSavingSchedule(UpdateStatusEvent event, Emitter<StatusUpdated> emit) {
  }
    Future<void> insertSchedule(UpdateStatusEvent event, Emitter<StatusUpdated> emit) async{
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
          .update({"status": event.status,})
          .eq("company_ref", event.companyRef as Object)
          ;
          await supabase.rpc("delete_unscheduled_companies");
          emit(StatusUpdated());
        }
  }
}
