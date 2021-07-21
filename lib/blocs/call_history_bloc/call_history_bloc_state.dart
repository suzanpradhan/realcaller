part of 'call_history_bloc_bloc.dart';

abstract class CallHistoryBlocState extends Equatable {
  const CallHistoryBlocState();

  @override
  List<Object> get props => [];
}

class CallHistoryBlocInitial extends CallHistoryBlocState {}

class AllCallLogLoadingOfPhone extends CallHistoryBlocState {}

class AllCallLogLoadedOfPhone extends CallHistoryBlocState {
  final List<CallLogEntry> allCallLogs;

  AllCallLogLoadedOfPhone({required this.allCallLogs});
  List<Object> get props => [allCallLogs];
}

class NoCallLogsOfPhone extends CallHistoryBlocState {
  final String message;

  NoCallLogsOfPhone({this.message = ""});
  List<Object> get props => [message];
}

class AllCallLogLoadFailedOfPhone extends CallHistoryBlocState {
  final String errorMessage;

  AllCallLogLoadFailedOfPhone({this.errorMessage = ""});
  List<Object> get props => [errorMessage];
}
