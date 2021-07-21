part of 'smslisting_bloc.dart';

abstract class SmslistingState extends Equatable {
  const SmslistingState();

  @override
  List<Object> get props => [];
}

class SmslistingInitial extends SmslistingState {}

class SmsAllMessageContactsLoading extends SmslistingState {}

class SmsAllMessageContactsLoaded extends SmslistingState {}

class SmsAllMessageContactsFailed extends SmslistingState {
  final String message;
  SmsAllMessageContactsFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class NoSmsAllMessageContacts extends SmslistingState {
  final String message;
  NoSmsAllMessageContacts({required this.message});

  @override
  List<Object> get props => [message];
}
