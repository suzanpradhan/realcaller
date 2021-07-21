import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/utils/constants/profiles_images.dart';
import 'package:telephony/telephony.dart';

class SmsRepo {
  final Telephony telephony = Telephony.instance;

  Future<List<SmsListing>> getAllMessages() async {
    // bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    // print(permissionsGranted);
    // if (permissionsGranted != null && permissionsGranted == true) {
    final List<SmsMessage> inboxMessages = await telephony.getInboxSms();
    final List<SmsMessage> sentMessages = await telephony.getSentSms();

    List<SmsMessage> messages = inboxMessages + sentMessages;
    messages.sort((a, b) {
      return (b.date!).compareTo(a.date!);
    });

    List<SmsListing> smsListings = [];

    for (SmsMessage message in messages) {
      final isAlreadyExist =
          smsListings.where((element) => element.name == message.address);
      if (isAlreadyExist.isEmpty) {
        smsListings.add(SmsListing(
            id: message.id!,
            name: message.address!,
            recentMessage: (message.body != null) ? message.body! : "",
            recentMessageTime: getSmsTimeFormatted(message.date),
            userProfileImage: AssetImage(ProfileImages().getRandomImage()),
            time: (message.date != null) ? message.date! : 0));
      }
    }
    return smsListings;
    // } else {
    //   return [];
    // }
  }

  String getSmsTimeFormatted(int? dateTime) {
    if (dateTime != null) {
      return DateTimeFormat.relative(
          DateTime.fromMillisecondsSinceEpoch(dateTime),
          abbr: true);
    } else {
      return "";
    }
  }

  Future<List<SmsMessage>> getMessagesOfAddress(String address) async {
    List<SmsMessage> inboxSms = await telephony.getInboxSms(
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals(address));
    inboxSms.forEach((element) {
      element.type = SmsType.MESSAGE_TYPE_INBOX;
    });
    List<SmsMessage> sentSms = await telephony.getSentSms(
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals(address));
    List<SmsMessage> messages = inboxSms + sentSms;
    messages.sort((a, b) {
      return (b.date!).compareTo(a.date!);
    });

    return messages;
  }
}
