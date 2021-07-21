part of 'locationchecker_bloc.dart';

abstract class LocationcheckerEvent extends Equatable {
  const LocationcheckerEvent();

  @override
  List<Object> get props => [];
}

class CheckLocationEvent extends LocationcheckerEvent {}
