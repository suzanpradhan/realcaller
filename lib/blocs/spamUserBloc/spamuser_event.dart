part of 'spamuser_bloc.dart';

abstract class SpamuserEvent extends Equatable {
  const SpamuserEvent();

  @override
  List<Object> get props => [];
}

class RequestAllSpams extends SpamuserEvent {}
