import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:realcallerapp/utils/extensions/string_extensions.dart';

class CallLogRepo {
  List<CallLogEntry> entriesList = <CallLogEntry>[];
  Future<List<CallLogEntry>> getAllCallLog() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    entriesList = entries.toList();
    return entriesList;
  }

  static String? getCallLogDisplayName({String? name, String? number}) {
    if (name != null && name != "") {
      return name;
    } else {
      return number;
    }
  }

  static String getCallType({required CallType callType}) {
    return callType.toString().split(".").last.capitalize();
  }

  static Icon getCallTypeIcon({required CallType callType}) {
    switch (callType) {
      case CallType.incoming:
        return Icon(
          Icons.call_received,
          color: Colors.green,
          size: 14,
        );
      case CallType.outgoing:
        return Icon(
          Icons.call_made,
          color: Colors.green,
          size: 14,
        );
      case CallType.missed:
        return Icon(
          Icons.call_missed,
          color: Colors.red,
          size: 14,
        );
      case CallType.rejected:
        return Icon(
          Icons.call_missed_outgoing,
          color: Colors.red,
          size: 14,
        );
      default:
        return Icon(
          Icons.call_missed,
          color: Colors.red,
          size: 14,
        );
    }
  }
}
