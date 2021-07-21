import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:call_log/call_log.dart';
import 'package:equatable/equatable.dart';

part 'call_history_bloc_event.dart';
part 'call_history_bloc_state.dart';

class CallHistoryBlocBloc
    extends Bloc<CallHistoryBlocEvent, CallHistoryBlocState> {
  CallHistoryBlocBloc() : super(CallHistoryBlocInitial());

  @override
  Stream<CallHistoryBlocState> mapEventToState(
    CallHistoryBlocEvent event,
  ) async* {
    if (event is RequestAllCallLogOfSpecificPhone) {
      yield* requestAllCallOfPhone(phone: event.phone);
    }
  }

  Stream<CallHistoryBlocState> requestAllCallOfPhone(
      {required String phone}) async* {
    Iterable<CallLogEntry> entries = await CallLog.query(number: phone);
    List<CallLogEntry> entriesList = entries.toList();
    print(entriesList.length);
    if (entries.length == 0) {
      yield NoCallLogsOfPhone(message: "No Call Logs.");
    } else {
      yield AllCallLogLoadedOfPhone(allCallLogs: entriesList);
    }
  }
}
