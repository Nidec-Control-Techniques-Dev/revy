import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'delegation_event_2.dart';
part 'delegation_state_2.dart';

class DelegationBloc extends Bloc<DelegationEvent, DelegationState> {
  // final Map<String, Map<String, List<String>>> salespersonDetails = {
    
  //   //Store salesperson data from initial loading
  //   'Salesperson 1': {
  //     'countries': ['Country 1'],
  //     'states': ['State 1'],
  //     'businessModels': ['Model 1'],
  //     'businessCategories': ['Category 1'],
  //   },
  //   'Salesperson 2': {
  //     'countries': ['Country 2'],
  //     'states': ['State 2'],
  //     'businessModels': ['Model 2'],
  //     'businessCategories': ['Category 2'],
  //   },
  //   'Salesperson 3': {
  //     'countries': ['Country 3'],
  //     'states': ['State 3'],
  //     'businessModels': ['Model 3'],
  //     'businessCategories': ['Category 3'],
  //   },
  // };



  DelegationBloc() : super(const DelegationState()) {
    // Figure out how to connect 2 supabase
    // Filter data for UUID from supabase
    // Find table representing delegations
    on<LoadSalespersonDetails>(_onInitializeSupabase);

    //add on<InitialLoading>

    on<UpdateDetails>((event, emit) {
      emit(state.copyWith(
        countries: event.countries,
        states: event.states,
        businessModels: event.businessModels,
        businessCategories: event.businessCategories,
      ));
    });

    on<ApplyChanges>(_updateConfig);
  }
  Future<void> _updateConfig(ApplyChanges event, Emitter<DelegationState> emit) async {
    final supabase = Supabase.instance.client;
    // await supabase.auth.signInWithPassword(
    //   email: 'markbadua92@gmail.com',
    //   password: 'hiqzu7-wexgor-nijGet',
    // );
    print('Supabase initialized successfully.');
    final user = supabase.auth.currentUser;

    if (user != null) {
      print("getting businessModelRefs");
      final businessModelRefs = await supabase
        .from("business_models")
        .select("uuid")
        .filter("name", "in", state.businessModels);
      print("getting categories");
      final categoryRefs = await supabase
        .from("categories")
        .select("uuid")
        .filter("name", "in", state.businessCategories);
      print("getting countries");
      final countryRefs = await supabase
        .from("countries")
        .select("uuid")
        .filter("name", "in", state.countries);
      print("getting states");
      final stateRefs = await supabase
        .from("states")
        .select("uuid")
        .filter("name", "in", state.states);
      
      print("--------------------");
      print(state.selectedSalespersonRef);
      print("--------------------");

      await supabase.rpc(
        "update_delegations",
        params: {
          "sales_person_ref": state.selectedSalespersonRef,
          "business_models": businessModelRefs.map((item) => item['uuid'] as String).toList(),
          "categories": categoryRefs.map((item) => item['uuid'] as String).toList(),
          "countries": countryRefs.map((item) => item['uuid'] as String).toList(),
          "states": stateRefs.map((item) => item['uuid'] as String).toList()
        }
      ); 
      emit(state.copyWith(
        previousCountries: state.countries,
        previousStates: state.states,
        previousBusinessModels: state.businessModels,
        previousBusinessCategories: state.businessCategories,
      ));
    }


  }

  Future<void> _onInitializeSupabase(LoadSalespersonDetails event, Emitter<DelegationState> emit) async {
      // TODO: get salespersonDetails
    final supabase = Supabase.instance.client;
    // await supabase.auth.signInWithPassword(
    //   email: 'markbadua92@gmail.com',
    //   password: 'hiqzu7-wexgor-nijGet',
    // );
    print('Supabase initialized successfully.');
    final user = supabase.auth.currentUser; 

    // final details = salespersonDetails[event.salesperson];
    if (user != null) {

      String userUid = user.id;
      final delegations = await supabase
        .from("delegations")
        .select("business_model_refs, category_refs, country_refs, state_refs")
        .eq('delegated_to_ref', event.salespersonRef);
      print("---------");
      print("delegations");
      print(delegations);
      print("---------");

      List<String> businessModelRefs = List<String>.from(delegations[0]["business_model_refs"]);
      List<String> categoryRefs = List<String>.from(delegations[0]["category_refs"]);
      List<String> countryRefs = List<String>.from(delegations[0]["country_refs"]);
      List<String> stateRefs = List<String>.from(delegations[0]["state_refs"]);

      final countryNames = await supabase
        .from("countries")
        .select("uuid, name")
        .filter('uuid', 'in', countryRefs);
      final stateNames = await supabase
        .from("states")
        .select("uuid, name")
        .filter('uuid', 'in', stateRefs);
      final businessModelNames = await supabase
        .from("business_models")
        .select("uuid, name")
        .filter('uuid', 'in', businessModelRefs);
      final categoryNames = await supabase
        .from("categories")
        .select("uuid, name")
        .filter('uuid', 'in', categoryRefs);

      emit(DelegationState(
        selectedSalesperson: event.salesperson,
        selectedSalespersonRef: event.salespersonRef,
        countries: countryNames.map((item) => item['name'] as String).toList(),
        states: stateNames.map((item) => item['name'] as String).toList(),
        businessModels: businessModelNames.map((item) => item['name'] as String).toList(),
        businessCategories: categoryNames.map((item) => item['name'] as String).toList(),
        previousCountries: countryNames.map((item) => item['name'] as String).toList(),
        previousStates: stateNames.map((item) => item['name'] as String).toList(),
        previousBusinessModels: businessModelNames.map((item) => item['name'] as String).toList(),
        previousBusinessCategories: categoryNames.map((item) => item['name'] as String).toList()
      ));
      // emit(DelegationState(
      //   selectedSalesperson: event.salesperson,
      //   selectedSalespersonRef: event.salespersonRef,
      //   countries: delegations[0]["business_model_refs"],
      //   states: delegations[0]["business_model_refs"],
      //   businessModels: delegations[0]["business_model_refs"],
      //   businessCategories: delegations[0]["business_model_refs"],
      //   previousCountries: delegations[0]["business_model_refs"],
      //   previousStates: delegations[0]["business_model_refs"],
      //   previousBusinessModels: delegations[0]["business_model_refs"],
      //   previousBusinessCategories: delegations[0]["business_model_refs"]
      // ));
    }
  }


}
