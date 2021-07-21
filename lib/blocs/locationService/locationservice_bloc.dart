import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';
import 'package:realcallerapp/repositories/phone_auth_repository.dart';
import 'package:realcallerapp/service/location_service.dart';

part 'locationservice_event.dart';
part 'locationservice_state.dart';

class LocationserviceBloc
    extends Bloc<LocationserviceEvent, LocationserviceState> {
  LocationService locationService = LocationService();
  PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();
  FirestoreRepo firestoreRepo = FirestoreRepo();
  LocationserviceBloc() : super(LocationserviceInitial());

  @override
  Stream<LocationserviceState> mapEventToState(
    LocationserviceEvent event,
  ) async* {
    if (event is GetCurrentUserLocation) {
      yield* getCurrentUserLocation();
    }
  }

  Stream<LocationserviceState> getCurrentUserLocation() async* {
    try {
      final Placemark address =
          await locationService.getMyLocationAddressDirect();
      final String userID = _phoneAuthRepository.getLoggedInUserID();
      firestoreRepo.updateUserAddress(
          userID: userID, address: "${address.locality} ${address.country}");
      yield CurrentUserLocationUpdatedState(address: address);
    } catch (e) {
      print(e.toString());
      yield CurrentUserLocationUpdateFailedState();
    }
  }
}
