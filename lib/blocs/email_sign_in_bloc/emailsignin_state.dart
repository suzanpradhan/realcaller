part of 'emailsignin_bloc.dart';

abstract class EmailsigninState extends Equatable {
  const EmailsigninState();

  @override
  List<Object> get props => [];
}

class EmailsigninInitial extends EmailsigninState {}

class EmailSignInLoading extends EmailsigninState {}

class EmailSignInSuccess extends EmailsigninState {}

class EmailSignInFailed extends EmailsigninState {
  final String message;
  const EmailSignInFailed({required this.message});

  @override
  List<Object> get props => [message];
}
