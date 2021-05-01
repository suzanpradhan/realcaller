import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:call_log/call_log.dart';
import 'package:equatable/equatable.dart';

part 'calllogbloc_event.dart';
part 'calllogbloc_state.dart';

class CalllogblocBloc extends Bloc<CalllogblocEvent, CalllogblocState> {
  CalllogblocBloc() : super(CalllogblocInitial());

  @override
  Stream<CalllogblocState> mapEventToState(
    CalllogblocEvent event,
  ) async* {
    if (event is RequestAllCallLogEvent) {
      Iterable<CallLogEntry> entries = await CallLog.get();
      List<CallLogEntry> entriesList = entries.toList();
      if (entries.length == 0) {
        yield NoCallLogs(message: "No Call Logs.");
      } else {
        yield AllCallLogLoaded(allCallLogs: entriesList);
      }
    }
  }
}
