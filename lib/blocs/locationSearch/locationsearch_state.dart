part of 'locationsearch_bloc.dart';

abstract class LocationsearchState extends Equatable {
  const LocationsearchState();

  @override
  List<Object> get props => [];
}

class LocationsearchInitial extends LocationsearchState {}

class LocationSearchLoading extends LocationsearchState {}

class LocationSearchLoaded extends LocationsearchState {
  final List<BasicUser> listOfUser;
  LocationSearchLoaded({required this.listOfUser});

  @override
  List<Object> get props => [listOfUser];
}

class LocationSearchLaodFailed extends LocationsearchState {
  final String message;
  LocationSearchLaodFailed({required this.message});

  @override
  List<Object> get props => [message];
}
