part of 'searchcontact_bloc.dart';

abstract class SearchcontactState extends Equatable {
  const SearchcontactState();

  @override
  List<Object> get props => [];
}

class SearchcontactInitial extends SearchcontactState {}

class ContactSearchLoading extends SearchcontactState {}

class ContactSearchLoaded extends SearchcontactState {
  final List<Contact> contacts;
  ContactSearchLoaded({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

class ContactSearchLoadFailed extends SearchcontactState {
  final String message;
  ContactSearchLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class ContactSearchNoContacts extends SearchcontactState {
  final String message;
  ContactSearchNoContacts({required this.message});

  @override
  List<Object> get props => [message];
}
