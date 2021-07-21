part of 'locationservice_bloc.dart';

abstract class LocationserviceEvent extends Equatable {
  const LocationserviceEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentUserLocation extends LocationserviceEvent {}
