part of 'permissonbloc_bloc.dart';

abstract class PermissonblocEvent extends Equatable {
  const PermissonblocEvent();

  @override
  List<Object> get props => [];
}

class RequestAllPermission extends PermissonblocEvent {}

class AllPermissionGrantedEvent extends PermissonblocEvent {}
