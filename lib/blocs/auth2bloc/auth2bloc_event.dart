part of 'auth2bloc_bloc.dart';

abstract class Auth2blocEvent extends Equatable {
  const Auth2blocEvent();

  @override
  List<Object> get props => [];
}

class CheckPermissionStatusEvent extends Auth2blocEvent {}

class CheckUserLoginStatusEvent extends Auth2blocEvent {}

class CheckUserIsFirstTimeEvent extends Auth2blocEvent {}

class CheckUserHasProfile extends Auth2blocEvent {}
