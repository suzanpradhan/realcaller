part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class RegisterFormSubmissionLoading extends AuthState {}

class RegisterFormSubmittedState extends AuthState {}

class RegisterFormSubmissionSuccess extends AuthState {}

class RegisterFormSubmissionFailed extends AuthState {
  final String errorMessage;

  RegisterFormSubmissionFailed({this.errorMessage = ""});
  @override
  List<Object> get props => [errorMessage];
}
