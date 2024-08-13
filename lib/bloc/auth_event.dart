part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  AuthSignUp(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
