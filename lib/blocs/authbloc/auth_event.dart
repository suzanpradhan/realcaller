part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegistrationFormSubmitEvent extends AuthEvent {
  final BasicUser user;
  final String password;
  final String confirmPassword;

  RegistrationFormSubmitEvent(
      {required this.user,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object> get props => [user, password, confirmPassword];
}
