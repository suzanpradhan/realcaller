part of 'discoverpeople_bloc.dart';

abstract class DiscoverpeopleState extends Equatable {
  const DiscoverpeopleState();

  @override
  List<Object> get props => [];
}

class DiscoverpeopleInitial extends DiscoverpeopleState {}

class DiscoverPeopleLoaded extends DiscoverpeopleState {
  final List<BasicUser> discoveredPeoples;
  DiscoverPeopleLoaded({required this.discoveredPeoples});

  @override
  List<Object> get props => [discoveredPeoples];
}

class DiscoverPeopleLoadFailed extends DiscoverpeopleState {
  final String message;
  DiscoverPeopleLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class DiscoverPeopleLoading extends DiscoverpeopleState {}
