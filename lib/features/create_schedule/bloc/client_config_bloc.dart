import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
// import '../../../env/env.dart';

part 'client_config_event.dart';
part 'client_config_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial()) {
    on<InitializeSupabase>(_onInitializeSupabase);
  }

  Future<void> _onInitializeSupabase(InitializeSupabase event, Emitter<DataState> emit) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithPassword(
        email: 'nidec.ct.dev@gmail.com',
        password: 'Qwerty1234',
      );
      emit(SupabaseInitialized());
      print('Supabase initialized successfully.');
    } catch (e) {
      emit(DataError(e.toString()));
      print('Error initializing Supabase: $e');
      return;
    }

    try {
      print('Fetching states...');
      final statesResponse = await Supabase.instance.client
          .from('states')
          .select('uuid, name')
          .eq('country_ref', '3a55c85a-182a-4d80-854f-a9409631df6b');

      final businessModelsResponse = await Supabase.instance.client
          .from('business_models')
          .select('uuid, name');

      final categoriesResponse = await Supabase.instance.client
          .from('categories')
          .select('uuid, name');
      print('Categories response: $categoriesResponse');

      final statesOptions = (statesResponse as List)
          .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
          .toList();

      final businessModelsOptions = (businessModelsResponse as List)
          .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
          .toList();

      final categoriesOptions = (categoriesResponse as List)
          .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
          .toList();

      emit(DataLoaded(
        statesOptions: statesOptions,
        businessModelsOptions: businessModelsOptions,
        categoriesOptions: categoriesOptions,
      ));
    } catch (e) {
      emit(DataError(e.toString()));
      print('Error fetching data: $e');
    }
  }

  //   Future<void> generateSchedule(DataEvent event, Emitter<DataState> emit) async {
  //   try {
  //     final supabase = Supabase.instance.client;
  //     await supabase.auth.signInWithPassword(
  //       email: 'nidec.ct.dev@gmail.com',
  //       password: 'Qwerty1234',
  //     );
  //     emit(SupabaseInitialized());
  //     print('Supabase initialized successfully.');
  //   } catch (e) {
  //     emit(DataError(e.toString()));
  //     print('Error initializing Supabase: $e');
  //     return;
  //   }

  //   // final List<String> companyRefs = [
  //   //   'uuid1',
  //   //   'uuid2',
  //   //   'uuid3',
  //   //   // Add more UUIDs as needed
  //   // ];
  //   // final orCondition = companyRefs.map((uuid) => 'company_ref.eq.$uuid').join(',');

  //   try {
  //     print('Fetching states...');
  //   final businessModelCategoryFiltered = await Supabase.instance.client
  //       .from('company_clients')
  //       .select('company_ref')
  //       .contains('business_model_refs', [])
  //       ;

  //   final addressesResponse = await Supabase.instance.client
  //       .from('company_addresses')
  //       .select('company_ref, full_text')
  //       .eq('country_ref', '3a55c85a-182a-4d80-854f-a9409631df6b')
  //       .or(orCondition);


  //     final addresses = (addressesResponse as List)
  //         .map((item) => ValueItem(label: item['full_text'] as String, value: item['full_text'] as String))
  //         .toList();
  //     final addresses = (addressesResponse as List)
  //         .map((item) => ValueItem(label: item['full_text'] as String, value: item['full_text'] as String))
  //         .toList();

  //     emit(AddressLoaded(
  //       availableAddresses: addresses,
  //     ));
  //   } catch (e) {
  //     emit(DataError(e.toString()));
  //     print('Error fetching data: $e');
  //   }
  // }
}


// import 'package:bloc/bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../../env/env.dart';

// part 'client_config_event.dart';
// part 'client_config_state.dart';

// class DataBloc extends Bloc<DataEvent, DataState> {
//   DataBloc() : super(DataInitial()) {
//     on<InitializeSupabase>(_onInitializeSupabase);
//   }

//   Future<void> _onInitializeSupabase(InitializeSupabase event, Emitter<DataState> emit) async {
//     try {

//       final supabase = await Supabase.instance.client;
//       // await Supabase.initialize(
//       //   url: 'https://vngqmoieqkgihvnpudwa.supabase.co',
//       //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZuZ3Ftb2llcWtnaWh2bnB1ZHdhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM5OTc1MDgsImV4cCI6MjAyOTU3MzUwOH0.yEWsHgV4WquWIV0aWUbXeIaCYCrF8UOAEnwdzL3xNjA',
//       // );
//       // await Supabase.instance.client.auth.signIn(
//       //   email: 'nidec.ct.dev@gmail.com',
//       //   password: 'Qwerty1234'
//       // );
//       await supabase.auth.signInWithPassword(
//         email: 'nidec.ct.dev@gmail.com',
//         password: 'Qwerty1234',
//       );
//       emit(SupabaseInitialized());
//       print('Supabase initialized successfully.');
//     } catch (e) {
//       emit(DataError(e.toString()));
//       print('Error initializing Supabase: $e');
//       return;
//     }

//     try {
//       final statesResponse = await Supabase.instance.client
//           .from('states')
//           .select('uiid,name')
//           .eq('country_ref', '3a55c85a-182a-4d80-854f-a9409631df6b');

//       final businessModelsResponse = await Supabase.instance.client
//           .from('business_models')
//           .select('uuid,name');

//       final categoriesResponse = await Supabase.instance.client
//           .from('categories')
//           .select('uuid,name');

//       final statesOptions = (statesResponse.data as List)
//           .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
//           .toList();

//       final businessModelsOptions = (businessModelsResponse.data as List)
//           .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
//           .toList();

//       final categoriesOptions = (categoriesResponse.data as List)
//           .map((item) => ValueItem(label: item['name'] as String, value: item['uuid'] as String))
//           .toList();

//       emit(DataLoaded(
//         statesOptions: statesOptions,
//         businessModelsOptions: businessModelsOptions,
//         categoriesOptions: categoriesOptions,
//       ));
//     } catch (e) {
//       emit(DataError(e.toString()));
//     }
//   }
// }



// class DataBloc extends Bloc<DataEvent, DataState> {
//   DataBloc() : super(DataInitial());

//   Stream<DataState> mapEventToState(DataEvent event) async* {
//     if (event is InitializeSupabase) {
//       try {
//         await Supabase.initialize(
//           url: Env.publicSupabaseUrl,
//           anonKey: Env.publicSupabaseAnonKey,
//         );
//         yield SupabaseInitialized();
//       } catch (e) {
//         yield DataError(e.toString());
//       }
//       final statesResponse = await Supabase.instance.client
//           .from('states')
//           .select('name')
//           .eq('country_ref', '3a55c85a-182a-4d80-854f-a9409631df6b');

//       final businessModelsResponse = await Supabase.instance.client
//           .from('business_models')
//           .select('name');

//       final categoriesResponse = await Supabase.instance.client
//           .from('companies')
//           .select('name');


//       final statesOptions = (statesResponse as List)
//           .map((item) => item['name'] as String)
//           .toList();

//       final businessModelsOptions = (businessModelsResponse as List)
//         .map((item) => item['name'] as String)
//         .toList();

//       final categoriesOptions = (categoriesResponse as List)
//         .map((item) => item['name'] as String)
//         .toList();

//       yield DataLoaded(
//         statesOptions: statesOptions,
//         businessModelsOptions:businessModelsOptions,
//         categoriesOptions:categoriesOptions,
//       );
//     }
//   }
// }




// // data_bloc.dart
// import 'package:bloc/bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// part 'client_config_event.dart';
// part 'client_config_state.dart';

// class DataBloc extends Bloc<DataEvent, DataState> {
//   DataBloc() : super(DataInitial());

//   Stream<DataState> mapEventToState(DataEvent event) async* {
//     if (event is FetchData) {
//       yield DataLoading();
//       try {
//         final response = await Supabase.instance.client
//             .from('your_table')
//             .select()
//             .execute();
//         if (response.error != null) {
//           yield DataError(response.error!.message);
//         } else {
//           yield DataLoaded(response.data);
//         }
//       } catch (e) {
//         yield DataError(e.toString());
//       }
//     }
//   }
// }
