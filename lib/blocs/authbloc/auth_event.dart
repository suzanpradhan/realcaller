part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// class RegistrationFormSubmitEvent extends AuthEvent {
//   final BasicUser user;
//   final String password;
//   final String confirmPassword;

//   RegistrationFormSubmitEvent(
//       {required this.user,
//       required this.password,
//       required this.confirmPassword});

//   @override
//   List<Object> get props => [user, password, confirmPassword];
// }

class LoadLoginFormEvent extends AuthEvent {}

class VerificationFormLoadEvent extends AuthEvent {
  final String phoneNumber;
  const VerificationFormLoadEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneNumberChanged extends AuthEvent {
  final String phoneNumber;
  const PhoneNumberChanged({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class LoginFromPhoneSubmitEvent extends AuthEvent {
  final CountryCode countryCode;
  final String phoneNumber;
  LoginFromPhoneSubmitEvent({
    required this.countryCode,
    required this.phoneNumber,
  });
}

class VerificationCodeChanged extends AuthEvent {
  final String code;
  const VerificationCodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}

class VerificationCodeSubmitEvent extends AuthEvent {
  final String code;
  const VerificationCodeSubmitEvent({required this.code});

  @override
  List<Object> get props => [code];
}

class GotVerifictionCodeEvent extends AuthEvent {
  final String verificationID;
  const GotVerifictionCodeEvent({required this.verificationID});

  @override
  List<Object> get props => [verificationID];
}

class AllPermissionGranted extends AuthEvent {}

class ResendCodeVerification extends AuthEvent {
  final String phoneNumber;
  const ResendCodeVerification({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}
