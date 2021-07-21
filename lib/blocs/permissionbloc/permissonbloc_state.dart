part of 'permissonbloc_bloc.dart';

abstract class PermissonblocState extends Equatable {
  const PermissonblocState();

  @override
  List<Object> get props => [];
}

class PermissonblocInitial extends PermissonblocState {}

class RequestAllPermissionLoading extends PermissonblocState {}

class RequestAllPermissionLoaded extends PermissonblocState {}

class PermissionDenied extends PermissonblocState {}
