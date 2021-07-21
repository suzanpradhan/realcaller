part of 'searchcontact_bloc.dart';

abstract class SearchcontactEvent extends Equatable {
  const SearchcontactEvent();

  @override
  List<Object> get props => [];
}

class RequestAllContacts extends SearchcontactEvent {}

class RequestContactsBySearch extends SearchcontactEvent {
  final String searchValue;
  RequestContactsBySearch({required this.searchValue});

  @override
  List<Object> get props => [searchValue];
}
