import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:realcallerapp/repositories/call_log_repo.dart';
import 'package:realcallerapp/repositories/contacts_repository.dart';

class CallLogUIModel {
  String accountID;
  String displayName;
  ImageProvider? userProfileImage;
  int? duration;
  Icon? callTypeIcon;
  String? callType;
  String phone;

  CallLogUIModel(
      {required this.accountID,
      required this.displayName,
      this.userProfileImage,
      this.duration,
      required this.callTypeIcon,
      required this.callType,
      this.phone = ""});

  static Future<CallLogUIModel> getCallLogUIModel(
      CallLogEntry callLogEntry) async {
    return CallLogUIModel(
        accountID: callLogEntry.phoneAccountId!,
        phone: callLogEntry.number!,
        displayName:
            "${CallLogRepo.getCallLogDisplayName(name: callLogEntry.name, number: callLogEntry.number)}",
        callType: CallLogRepo.getCallType(callType: callLogEntry.callType!),
        callTypeIcon:
            CallLogRepo.getCallTypeIcon(callType: callLogEntry.callType!),
        duration: callLogEntry.duration,
        userProfileImage: await ContactsRepository.getContactProfileImage(
            phone: callLogEntry.number!));
  }
}
