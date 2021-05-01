part of 'calllogbloc_bloc.dart';

abstract class CalllogblocEvent extends Equatable {
  const CalllogblocEvent();

  @override
  List<Object> get props => [];
}

class RequestAllCallLogEvent extends CalllogblocEvent {}
