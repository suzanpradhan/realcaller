part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginFormLoading extends AuthState {}

class LoginFormActive extends AuthState {}

class LoginFormDisabled extends AuthState {}

class LoginFormSubmissionLoading extends AuthState {}

class LoginFormSubmittedState extends AuthState {}

class LoginFormSubmissionSuccess extends AuthState {
  final String phoneNumber;

  const LoginFormSubmissionSuccess({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class LoginFormSubmissionFailed extends AuthState {
  final String errorMessage;

  LoginFormSubmissionFailed({this.errorMessage = ""});
  @override
  List<Object> get props => [errorMessage];
}

class LoginPhoneCodeSent extends AuthState {
  final String verificationId;

  LoginPhoneCodeSent({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}

class LoginFormVerificationFailed extends AuthState {
  final String errorMessage;

  LoginFormVerificationFailed({this.errorMessage = ""});
  @override
  List<Object> get props => [errorMessage];
}

class VerificationFormActive extends AuthState {}

class VerificationFormDisabled extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginSuccessWithoutUser extends AuthState {}

class LoginFailed extends AuthState {}

class VerificationCodeSentLoading extends AuthState {}

class VerificationCodeSendSuccess extends AuthState {
  final String verificationID;
  const VerificationCodeSendSuccess({required this.verificationID});

  @override
  List<Object> get props => [verificationID];
}

class AllPermissionGrantedState extends AuthState {}
