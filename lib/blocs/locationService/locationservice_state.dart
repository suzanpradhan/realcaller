part of 'locationservice_bloc.dart';

abstract class LocationserviceState extends Equatable {
  const LocationserviceState();

  @override
  List<Object> get props => [];
}

class LocationserviceInitial extends LocationserviceState {}

class CurrentUserLocationUpdatedState extends LocationserviceState {
  final Placemark address;
  CurrentUserLocationUpdatedState({required this.address});

  @override
  List<Object> get props => [address];
}

class CurrentUserLocationUpdateFailedState extends LocationserviceState {}
