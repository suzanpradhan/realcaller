part of 'contactbloc_bloc.dart';

abstract class ContactblocEvent extends Equatable {
  const ContactblocEvent();

  @override
  List<Object> get props => [];
}

class RequestAllContactsEvent extends ContactblocEvent {}

class RequestSpecificContactEvent extends ContactblocEvent {
  final Contact contact;
  RequestSpecificContactEvent({required this.contact});
}
