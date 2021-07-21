import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:call_log/call_log.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/models/call_log.dart';
import 'package:realcallerapp/repositories/call_log_repo.dart';

part 'calllogbloc_event.dart';
part 'calllogbloc_state.dart';

class CalllogblocBloc extends Bloc<CalllogblocEvent, CalllogblocState> {
  CallLogRepo callLogRepo = CallLogRepo();
  CalllogblocBloc() : super(CalllogblocInitial());

  @override
  Stream<CalllogblocState> mapEventToState(
    CalllogblocEvent event,
  ) async* {
    if (event is RequestAllCallLogEvent) {
      yield AllCallLogLoading();
      // List<CallLogEntry> callLogEntries = await callLogRepo.getAllCallLog();
      try {
        Iterable<CallLogEntry> entries = await CallLog.get();
        List<CallLogEntry> entriesList = entries.toList();
        List<CallLogEntry> newList = [];
        for (CallLogEntry entry in entriesList) {
          final test =
              newList.where((element) => element.number == entry.number);
          if (test.isEmpty) {
            newList.add(entry);
          }
        }
        List<Future<CallLogUIModel>> modeledCallLogList = newList
            .map((CallLogEntry entry) async =>
                await CallLogUIModel.getCallLogUIModel(entry))
            .toSet()
            .toList();
        // Set<Future<CallLogUIModel>> modeledCallLogSet =
        //     Set<Future<CallLogUIModel>>();
        // modeledCallLogList = modeledCallLogSet
        //     .where((element) => modeledCallLogSet.add(element))
        //     .toList();
        print("previouse");
        if (entries.length == 0) {
          yield NoCallLogs(message: "No Call Logs.");
        } else {
          // print(
          //     "${entriesList[0].name!} ${entriesList[0].number!} ${entriesList[0].phoneAccountId!} ${entriesList[0].simDisplayName!} ${entriesList[0].timestamp.toString()}");
          yield AllCallLogLoaded(allCallLogs: modeledCallLogList);
        }
      } catch (e) {
        yield NoCallLogs(message: e.toString());
      }
    }
  }

  // Stream<CalllogblocState> requestAllCallLog() async* {
  //   List<CallLogEntry> callLogEntries = await callLogRepo.getAllCallLog();
  //   yield AllCallLogLoaded(allCallLogs: callLogEntries);
  // }

}
