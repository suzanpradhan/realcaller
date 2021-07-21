part of 'smslisting_bloc.dart';

abstract class SmslistingEvent extends Equatable {
  const SmslistingEvent();

  @override
  List<Object> get props => [];
}

class RequestAllMessageContacts extends SmslistingEvent {}
