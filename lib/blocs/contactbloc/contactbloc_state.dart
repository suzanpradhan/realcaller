part of 'contactbloc_bloc.dart';

abstract class ContactblocState extends Equatable {
  const ContactblocState();

  @override
  List<Object> get props => [];
}

class ContactblocInitial extends ContactblocState {}

class ContactsLoading extends ContactblocState {}

class ContactsLoaded extends ContactblocState {
  final Iterable<Contact> contacts;
  ContactsLoaded({required this.contacts});

  List<Object> get props => [contacts];
}

class NoContacts extends ContactblocState {
  final String message;

  NoContacts({this.message = ""});
  List<Object> get props => [message];
}

class ContactsLoadFailed extends ContactblocState {
  final String errorMessage;

  ContactsLoadFailed({this.errorMessage = ""});
  List<Object> get props => [errorMessage];
}

class SpecificContactLoaded extends ContactblocState {
  final Contact contact;
  SpecificContactLoaded({required this.contact});

  List<Object> get props => [contact];
}

class NoSpecificContactLoad extends ContactblocState {
  final String message;

  NoSpecificContactLoad({this.message = ""});
  List<Object> get props => [message];
}

class SpecificContactLoadFailed extends ContactblocState {
  final String errorMessage;

  SpecificContactLoadFailed({this.errorMessage = ""});
  List<Object> get props => [errorMessage];
}
