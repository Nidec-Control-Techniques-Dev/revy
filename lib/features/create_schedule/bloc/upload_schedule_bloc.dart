import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'upload_schedule_event.dart';
part 'upload_schedule_state.dart';

class UploadScheduleBloc extends Bloc<UploadScheduleEvent, UploadScheduleState> {
  UploadScheduleBloc() : super(ScheduleInitial()) {
    on<SaveSchedule>(_triggerSavingSchedule);
    on<SavingSchedule>(insertSchedule);
  }

  void _triggerSavingSchedule(UploadScheduleEvent event, Emitter<UploadScheduleState> emit) {
      emit(ScheduleIsSaving());
      add(SavingSchedule(
        scheduleDates: event.scheduleDates,
        startingAddress: event.startingAddress,
        companyRefs: event.companyRefs,
        availableCompanies: event.availableCompanies,
        companyAddresses: event.companyAddresses,
        annualSales: event.annualSales,
        businessModel: event.businessModel,
        categoryName: event.categoryName,
        subcategoryName: event.subcategoryName,
        contactNumber: event.contactNumber,
        email: event.email,
        faxNumber: event.faxNumber,
      ));
  }
  Future<void> insertSchedule(UploadScheduleEvent event, Emitter<UploadScheduleState> emit) async{
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
      
    if (user != null){
      String userUid = user.id;
      print("user $userUid");
      List<Future> futures = [];
      for (
        int dateIndex=0, startIndex =0, remaining = event.companyRefs.length, endIndex;
        (dateIndex < event.scheduleDates.length) & (remaining >0);
        dateIndex++, startIndex+=4
      ){
        if (remaining >= 4){
          endIndex = startIndex+ 4;
          remaining -= 4;
          futures.add(
            supabase.rpc(
              'update_scheduled_companies', 
              params: {
                'company_uuids': event.companyRefs.sublist(startIndex, endIndex),
                'email': '',
                'schedule_date_param': event.scheduleDates[dateIndex],
                'user_id': userUid
            })
          );
        }
        else{
          endIndex = remaining;
          remaining -=4;
          futures.add(
            supabase.rpc(
              'update_scheduled_companies', 
              params: {
                'company_uuids': event.companyRefs.sublist(startIndex, endIndex),
                'email': '',
                'schedule_date_param': event.scheduleDates[dateIndex],
                'user_id': userUid
            })
          );
          }
      }
        await Future.wait(futures);
        await supabase
        .from("schedule_starting_location")
        .insert({
          "address": event.startingAddress,
          "user_uid": userUid,
          "schedule_date": event.scheduleDates[0]
        });
      await supabase.rpc(
        "delete_unscheduled_companies_v2",
        params: {
          "uuid_param":userUid
        }
      );
      emit(ScheduleSavedState());
    }
        
        

  }
}