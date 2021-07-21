import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/repositories/phone_auth_repository.dart';
import 'package:realcallerapp/service/location_service.dart';

part 'locationchecker_event.dart';
part 'locationchecker_state.dart';

class LocationcheckerBloc
    extends Bloc<LocationcheckerEvent, LocationcheckerState> {
  LocationService _locationService = LocationService();
  PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();
  LocationcheckerBloc() : super(LocationcheckerInitial());

  @override
  Stream<LocationcheckerState> mapEventToState(
    LocationcheckerEvent event,
  ) async* {
    if (event is CheckLocationEvent) {
      yield* locationChecker();
    }
  }

  Stream<LocationcheckerState> locationChecker() async* {
    yield LocationCheckerLoading();
    final bool _isLocationEnabled = await _locationService.isLocationEnabled();
    if (!_isLocationEnabled) {
      print("here");
      yield LocationDisabledState();
    } else {
      print("object");
      final bool _isLocationPermissionGranted =
          await _locationService.isLocationPermissionAllowed();
      if (!_isLocationPermissionGranted) {
        yield LocationPermissionDenied();
      } else {
        yield LocationPermissionAllowed();
      }
    }
  }
}
