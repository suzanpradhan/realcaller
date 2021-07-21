part of 'emailsignin_bloc.dart';

abstract class EmailsigninEvent extends Equatable {
  const EmailsigninEvent();

  @override
  List<Object> get props => [];
}

class EmailFormSubmitted extends EmailsigninEvent {
  final String email;
  final String password;
  const EmailFormSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
