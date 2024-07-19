// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'upload_schedule_event.dart';
part 'upload_schedule_state.dart';

// part 'bloc/upload_schedule_bloc.freezed.dart';

class UploadScheduleBloc extends Bloc<UploadScheduleEvent, UploadScheduleState> {
  UploadScheduleBloc() : super(ScheduleInitial()) {
    on<SaveSchedule>(_triggerSavingSchedule);
    on<SavingSchedule>(insertSchedule);
  }

  void _triggerSavingSchedule(UploadScheduleEvent event, Emitter<UploadScheduleState> emit) {
      // Some logic
      // Trigger another event
      emit(ScheduleIsSaving());
      add(SavingSchedule(
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
        await supabase.auth.signInWithPassword(
          email: 'nidec.ct.dev@gmail.com',
          password: 'Qwerty1234',
        );
        final user = supabase.auth.currentUser;
        
        if (user != null){
          String userUid = user.id;
          print("user $userUid");
          await supabase.rpc('update_scheduled_companies', params: {
            'company_uuids': event.companyRefs,
            'email': '',
            'schedule_date_param': DateTime.now().toUtc().toIso8601String(),
            'user_id': userUid
          });
          await supabase
          .from("schedule_starting_location")
          .insert({
            "address": event.startingAddress,
            "user_uid": userUid
            // "schedule_date": DateTime.now()
          });
          await supabase.rpc("delete_unscheduled_companies");
          emit(ScheduleSavedState());
        }
      // try{
      //   await supabase.rpc('update_scheduled_companies', params: {
      //     'company_uuids': event.companyRefs,
      //     'email': 'nidec.ct.dev@gmail.com',
      //     'schedule_date': DateTime.now().toUtc().toIso8601String(),
      //   });
      //   emit(ScheduleSavedState());
      // }
      // catch (e){
      //   print(e);
      //   emit(ScheduleErrorState());
      // }
      // await Future.delayed(const Duration(seconds: 5));
  }
}
