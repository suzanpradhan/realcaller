import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:realcallerapp/utils/constants/profiles_images.dart';

class ContactsRepo2 {
  Future<List<Contact>> getAllContacts() async {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    return contacts.toList();
  }

  Future<List<Contact>> getContactsBySearch(
      {required String searchValue}) async {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    List<Contact> contactList = contacts.toList();
    contactList = contactList.where((element) {
      bool phoneCheck;
      if (element.phones!.isNotEmpty) {
        phoneCheck = element.phones!.first.value!.contains(searchValue);
      } else {
        phoneCheck = false;
      }
      return (element.displayName!
              .toLowerCase()
              .contains(searchValue.toLowerCase()) ||
          phoneCheck);
    }).toList();

    return contactList;
  }

  static Future<ImageProvider> getContactProfileImage(
      {required Contact contact}) async {
    final Uint8List? avatar = await ContactsService.getAvatar(contact);
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
  }
}
