// import 'package:flutter_bloc/flutter_bloc.dart';

// @injectable
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final IAuthenticationRepository _authenticationRepository;
//   StreamSubscription<User?>? _userSubscription;

//   AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
//     on<AuthInitialCheckRequested>(_onInitialAuthChecked);
//     on<AuthLogoutButtonPressed>(_onLogoutButtonPressed);  
//     on<AuthOnCurrentUserChanged>(_onCurrentUserChanged);

//     _startUserSubscription();
//   }
  
//   // event handlers and subscription logic
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignIn>(_onSignIn);
    on<AuthSignUp>(_onSignUp);
  }

  Future<void> _onSignIn(AuthSignIn event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    try {
      print("Getting supabase client");
      final supabase = Supabase.instance.client;
      print(supabase);
      print("Trying to log in");
      final response = await supabase.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      print('-------');
      print(response);
      print('-------');
      final user = supabase.auth.currentUser;
      print("user-----");
      print(user);
      print("user-----");
      if (user != null) {
        print("if case");
        String userUid = user.id;
        final distinctSalesPeopleUserId = await supabase.rpc("get_distinct_sales_user_uids"
        );
        final salesPeopleId = distinctSalesPeopleUserId.map((item) => item['user_uid']).toList();
        int isSalesPerson = 0;
        if (salesPeopleId.contains(userUid)) {
          isSalesPerson++;
        }
        emit(AuthAuthenticated(response, isSalesPerson));
      } else {
        print("else case");
        emit(AuthError('Authentication failed'));
      }
    } catch (e) {
      print("catch");
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthenticationState> emit) async {
    // emit(AuthLoading());
    // try {
    //   final response = await SupabaseClientInstance.supabase.auth.signUp(
    //     email: event.email,
    //     password: event.password,
    //   );
    //   if (response.user != null) {
    //     emit(AuthAuthenticated());
    //   } else {
    //     emit(AuthError('Sign up failed'));
    //   }
    // } catch (e) {
    //   emit(AuthError(e.toString()));
    // }
  }
}
