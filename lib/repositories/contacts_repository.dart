import 'dart:async';
import 'dart:typed_data';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:realcallerapp/utils/constants/profiles_images.dart';

class ContactsRepository {
  Future getAllContacts() async {}

  static Future<ImageProvider> getContactProfileImage(
      {required String phone}) async {
    Iterable<Contact> contacts =
        await ContactsService.getContactsForPhone(phone);
    List<Contact> contactsList = contacts.toList();
    if (contactsList.length > 0) {
      final Uint8List? avatar = contactsList.first.avatar;
      if (avatar != null && avatar.toString() != "[]") {
        try {
          print(avatar.toString());
          ImageProvider avatarImageProvider = MemoryImage(avatar, scale: 2);
          return avatarImageProvider;
        } catch (e) {
          ImageProvider avatarImageProvider =
              AssetImage(ProfileImages().getRandomImage());
          return avatarImageProvider;
        }
      } else {
        return AssetImage(ProfileImages().getRandomImage());
      }
    } else {
      print("3");
      return AssetImage(ProfileImages().getRandomImage());
    }
  }
}
