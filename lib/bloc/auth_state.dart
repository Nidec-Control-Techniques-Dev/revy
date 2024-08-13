
part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthAuthenticated extends AuthenticationState {
  final AuthResponse user;
  final int isSalesPerson;

  AuthAuthenticated(this.user, this.isSalesPerson);

  @override
  List<Object> get props => [AuthResponse];
}

class AuthError extends AuthenticationState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}
