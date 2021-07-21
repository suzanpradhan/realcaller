part of 'call_history_bloc_bloc.dart';

abstract class CallHistoryBlocEvent extends Equatable {
  const CallHistoryBlocEvent();

  @override
  List<Object> get props => [];
}

class RequestAllCallLogOfSpecificPhone extends CallHistoryBlocEvent {
  final String phone;
  const RequestAllCallLogOfSpecificPhone({required this.phone});

  @override
  List<Object> get props => [phone];
}
