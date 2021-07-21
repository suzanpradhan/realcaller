import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageRepo {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadProfileImage(
      {required File file, required String userID}) async {
    try {
      String fileExtension = path.extension(file.path);
      String filename = "${userID}_profile_image$fileExtension";
      await firebase_storage.FirebaseStorage.instance
          .ref('profiles/$filename')
          .putFile(file);
      String imageUrl =
          await storage.ref("profiles/$filename").getDownloadURL();
      return imageUrl;
    } on firebase_core.FirebaseException catch (e) {
      return "";
    }
  }

  Future<String> getProfileImage({required String imageName}) async {
    try {
      if (imageName == "") {
        return "";
      } else {
        String imageUrl =
            await storage.ref("profiles/$imageName").getDownloadURL();
        print(imageUrl);
        return imageUrl;
      }
    } catch (e) {
      return "";
    }
  }
}
