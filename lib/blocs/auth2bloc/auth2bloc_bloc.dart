import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';
import 'package:realcallerapp/repositories/phone_auth_repository.dart';
import 'package:realcallerapp/service/app_permissions.dart';

part 'auth2bloc_event.dart';
part 'auth2bloc_state.dart';

class Auth2blocBloc extends Bloc<Auth2blocEvent, Auth2blocState> {
  final PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();
  final FirestoreRepo _firestoreRepo = FirestoreRepo();
  AppPermission appPermission = AppPermission();
  Auth2blocBloc() : super(Auth2blocInitial());

  @override
  Stream<Auth2blocState> mapEventToState(
    Auth2blocEvent event,
  ) async* {
    if (event is CheckPermissionStatusEvent) {
      // CHECKING ALL THE APP PERMISSIONS
      yield* checkAllPermissions();
    } else if (event is CheckUserLoginStatusEvent) {
      // CHECKING IF USER IS LOGGED IN
      yield* checkLoginUserStatus();
    } else if (event is CheckUserIsFirstTimeEvent) {
      yield* checkIfUserIsFirstTime();
    } else if (event is CheckUserHasProfile) {
      yield* checkUserHasProfile();
    }
  }

  Stream<Auth2blocState> checkAllPermissions() async* {
    bool isAllPermissionGranted = await appPermission.isAllPermissionGranted();
    if (isAllPermissionGranted) {
      yield AllPermissionGrantedState();
    } else {
      yield NotAllPermissionGrantedState();
    }
  }

  Stream<Auth2blocState> checkLoginUserStatus() async* {
    bool isUserLoggedIn = _phoneAuthRepository.isLoggedIn();
    if (isUserLoggedIn) {
      yield UserHasLoggedInState();
    } else {
      yield UserHasNotBeenLoggedInState();
    }
  }

  Stream<Auth2blocState> checkIfUserIsFirstTime() async* {
    var isFirstTime = await Hive.openBox('isFirstTimeBox');
    print("Checking User First Time");
    if (isFirstTime.containsKey("value")) {
      var isFirstTimeValue = isFirstTime.get("value");
      if (isFirstTimeValue == 1) {
        yield UserIsNotFirstTimeState();
      } else {
        yield UserIsFirstTimeState();
      }
    } else {
      yield UserIsFirstTimeState();
    }
  }

  Stream<Auth2blocState> checkUserHasProfile() async* {
    bool isUserExist = await _firestoreRepo
        .checkUserExists(_phoneAuthRepository.getLoggedInUserID());
    if (isUserExist) {
      yield UserHasProfile();
    } else {
      yield UserHasNotProfile();
    }
  }
}
