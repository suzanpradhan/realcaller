import 'package:flutter/material.dart';

class SmsListing {
  int? id;
  String? name;
  String? recentMessage;
  String? recentMessageTime;
  ImageProvider? userProfileImage;
  int? time;

  SmsListing(
      {this.id,
      this.name,
      this.recentMessage,
      this.recentMessageTime,
      this.userProfileImage,
      this.time = 0});
}
