import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';

part 'locationsearch_event.dart';
part 'locationsearch_state.dart';

class LocationsearchBloc
    extends Bloc<LocationsearchEvent, LocationsearchState> {
  FirestoreRepo firestoreRepo = FirestoreRepo();

  LocationsearchBloc() : super(LocationsearchInitial());

  @override
  Stream<LocationsearchState> mapEventToState(
    LocationsearchEvent event,
  ) async* {
    if (event is SearchUserWithLocation) {
      yield* mapSearchEventToState(event: event);
    } else if (event is SearchUserByNumber) {
      yield* mapSearchByNumberEventToState(event: event);
    }
  }

  Stream<LocationsearchState> mapSearchEventToState({
    required SearchUserWithLocation event,
  }) async* {
    try {
      yield LocationSearchLoading();
      List<BasicUser> searchedUsers =
          await firestoreRepo.searchUserByLocation(username: event.searchvalue);
      yield LocationSearchLoaded(listOfUser: searchedUsers);
    } catch (e) {
      yield LocationSearchLaodFailed(message: e.toString());
    }
  }

  Stream<LocationsearchState> mapSearchByNumberEventToState({
    required SearchUserByNumber event,
  }) async* {
    try {
      yield LocationSearchLoading();
      print(event.countryCode.dialCode!);
      List<BasicUser> searchedUsers =
          await firestoreRepo.searchUserByNumberLocation(
              countryCode: event.countryCode.dialCode!, number: event.number);
      yield LocationSearchLoaded(listOfUser: searchedUsers);
    } catch (e) {
      yield LocationSearchLaodFailed(message: e.toString());
    }
  }
}
