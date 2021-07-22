part of 'spamuser_bloc.dart';

abstract class SpamuserState extends Equatable {
  const SpamuserState();

  @override
  List<Object> get props => [];
}

class SpamuserInitial extends SpamuserState {}

class AllUserSpamLoading extends SpamuserState {}

class AllUserSpamLoadSuccess extends SpamuserState {
  final List<SpamModel> listOfContacts;
  AllUserSpamLoadSuccess({required this.listOfContacts});

  @override
  List<Object> get props => [listOfContacts];
}

class AllUserSpamLoadFailed extends SpamuserState {
  final String message;
  AllUserSpamLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}
