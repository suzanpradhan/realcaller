part of 'auth2bloc_bloc.dart';

abstract class Auth2blocState extends Equatable {
  const Auth2blocState();

  @override
  List<Object> get props => [];
}

class Auth2blocInitial extends Auth2blocState {}

class AllPermissionGrantedState extends Auth2blocState {}

class NotAllPermissionGrantedState extends Auth2blocState {}

class UserHasLoggedInState extends Auth2blocState {}

class UserHasNotBeenLoggedInState extends Auth2blocState {}

class UserIsFirstTimeState extends Auth2blocState {}

class UserIsNotFirstTimeState extends Auth2blocState {}

class UserHasProfile extends Auth2blocState {}

class UserHasNotProfile extends Auth2blocState {}
