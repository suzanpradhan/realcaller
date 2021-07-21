part of 'discoverpeople_bloc.dart';

abstract class DiscoverpeopleEvent extends Equatable {
  const DiscoverpeopleEvent();

  @override
  List<Object> get props => [];
}

class RequestDiscoverPeople extends DiscoverpeopleEvent {}
