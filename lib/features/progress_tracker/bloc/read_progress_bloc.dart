import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
part 'read_progress_state.dart';
part 'read_progress_event.dart';

class ReadProgressBloc extends Bloc<ProgressTrackerEvent, ProgressTrackerState> {
  ReadProgressBloc() : super(ProgressTrackerState(latitude: [], longitude: [], clientName: [], address: [])) {
    on<ApplyButtonPressed>(_onInitializeSupabase);
  }

  Future<void> _onInitializeSupabase(
      ApplyButtonPressed event, Emitter<ProgressTrackerState> emit) async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user != null){
        String userUid = user.id;
        final clientResponse = await supabase.rpc("get_scheduled_info_v2",
          params: {
            "status_arr": event.filterStatus,
            "schedule_date_arr": getDaysInBetween(event.startDate, event.endDate),
            "user_id": userUid
          }
        );
        final latLong = await supabase
          .from("company_addresses")
          .select("latitude, longitude")
          .filter("company_ref", "in", clientResponse.map((item) => item['company_ref']).toList());

        List<dynamic> latitude = latLong.map((item) => item['latitude']).toList();
        List<dynamic> longitude = latLong.map((item) => item['longitude']).toList();
        emit(ProgressTrackerState(
          clientName: clientResponse.map((item) => item['company_name']).toList(), //all the parameters
          companyRef: clientResponse.map((item) => item['company_ref']).toList(), //all the parameters
          businessModel: clientResponse.map((item) => item['business_model_names']).toList(),
          category: clientResponse.map((item) => item['category_names']).toList(),
          address: clientResponse.map((item) => item['full_text']).toList(),
          annualSales: clientResponse.map((item) => item['annual_sales']).toList(),
          telephoneNumber: clientResponse.map((item) => item['contact_no']).toList(),
          email: clientResponse.map((item) => item['email']).toList(),
          faxNo: clientResponse.map((item) => item['fax_number']).toList(),
          status: clientResponse.map((item) => item['status']).toList(),
          scheduleDates: clientResponse.map((item) => item['schedule_date']).toList(),
          latitude: latitude,
          longitude: longitude
        ));
      }
    } 
    catch (e) {
      emit(DataError(e.toString(), latitude: [], longitude: [], clientName: [], address: []));
      print('Error: $e');
    }
  }

  List<String> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<String> days = [];
    for (DateTime current = startDate;
        current.isBefore(endDate) || current.isAtSameMomentAs(endDate);
        current = current.add(const Duration(days: 1))) {
      days.add(DateTime(current.year, current.month, current.day).toIso8601String().substring(0, 10));
    }
    return days;
  }

}


