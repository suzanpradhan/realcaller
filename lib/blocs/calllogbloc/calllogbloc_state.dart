part of 'calllogbloc_bloc.dart';

abstract class CalllogblocState extends Equatable {
  const CalllogblocState();

  @override
  List<Object> get props => [];
}

class CalllogblocInitial extends CalllogblocState {}

class AllCallLogLoading extends CalllogblocState {}

class AllCallLogLoaded extends CalllogblocState {
  final List<Future<CallLogUIModel>> allCallLogs;

  AllCallLogLoaded({required this.allCallLogs});
  List<Object> get props => [allCallLogs];
}

class NoCallLogs extends CalllogblocState {
  final String message;

  NoCallLogs({this.message = ""});
  List<Object> get props => [message];
}

class AllCallLogLoadFailed extends CalllogblocState {
  final String errorMessage;

  AllCallLogLoadFailed({this.errorMessage = ""});
  List<Object> get props => [errorMessage];
}
