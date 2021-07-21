part of 'locationchecker_bloc.dart';

abstract class LocationcheckerState extends Equatable {
  const LocationcheckerState();

  @override
  List<Object> get props => [];
}

class LocationCheckerLoading extends LocationcheckerState {}

class LocationcheckerInitial extends LocationcheckerState {}

class LocationEnabledState extends LocationcheckerState {}

class LocationDisabledState extends LocationcheckerState {}

class LocationPermissionAllowed extends LocationcheckerState {}

class LocationPermissionDenied extends LocationcheckerState {}
