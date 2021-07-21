import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';
import 'package:realcallerapp/src/screens/side_navigations_screens/discover_people.dart';

part 'discoverpeople_event.dart';
part 'discoverpeople_state.dart';

class DiscoverpeopleBloc
    extends Bloc<DiscoverpeopleEvent, DiscoverpeopleState> {
  FirestoreRepo firestoreRepo = FirestoreRepo();
  DiscoverpeopleBloc() : super(DiscoverpeopleInitial());

  @override
  Stream<DiscoverpeopleState> mapEventToState(
    DiscoverpeopleEvent event,
  ) async* {
    if (event is RequestDiscoverPeople) {
      yield* mapDiscoverPeopleToState();
    }
  }

  Stream<DiscoverpeopleState> mapDiscoverPeopleToState() async* {
    try {
      yield DiscoverPeopleLoading();
      List<BasicUser> discoveredPeoples = await firestoreRepo.discoverPeople();
      yield DiscoverPeopleLoaded(discoveredPeoples: discoveredPeoples);
    } catch (e) {
      yield DiscoverPeopleLoadFailed(message: e.toString());
    }
  }
}
