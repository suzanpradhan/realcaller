import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:realcallerapp/models/ads_model.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'package:realcallerapp/models/default_ads_model.dart';
import 'package:realcallerapp/models/spam_model.dart';

class FirestoreRepo {
  FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> checkUserExists(String userID) async {
    CollectionReference _userCollection =
        _firestoreInstance.collection("users");
    try {
      bool exist = false;
      await _userCollection.doc("$userID").get().then((doc) {
        if (doc.exists) {
          print(doc.id + " exists.");
          exist = true;
        } else {
          exist = false;
        }
      });
      return exist;
    } catch (e) {
      return false;
    }
  }

  User? getCurrentUser() {
    final User? user = _firebaseAuth.currentUser;
    return user;
  }

  Future<UserCredential> createAccountWithEmail(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> signInAccountWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errormessage = "Login Failed!";
      if (e.code == 'user-not-found') {
        errormessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errormessage = 'Wrong password provided for user.';
      }
      return Future.error(errormessage);
    } catch (e) {
      return Future.error("Login Failed!");
    }
  }

  AuthCredential getEmailAuthCredential(String email, String password) {
    AuthCredential authCredential =
        EmailAuthProvider.credential(email: email, password: password);
    return authCredential;
  }

  bool checkPhoneInDb(String phoneNumber) {
    bool status = false;
    _firestoreInstance
        .collection("users")
        .where("phone", isEqualTo: phoneNumber)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        print(snapshot.docs.first.data());
        status = true;
      } else {
        status = false;
      }
    });
    return status;
  }

  Future<bool> addUserToDb(BasicUser basicUser) async {
    CollectionReference _userCollection =
        _firestoreInstance.collection("users");

    try {
      _userCollection
          .doc(basicUser.userID)
          .set(basicUser.toMapForDb())
          .then((value) => print("User Added!"))
          .catchError((error) => print("Error: " + error.toString()));
      return await checkUserExists(basicUser.userID);
    } catch (e) {
      return false;
    }
  }

  Future<BasicUser> getUserData(String userID) async {
    CollectionReference _userCollection =
        _firestoreInstance.collection("users");
    try {
      DocumentSnapshot document = await _userCollection.doc("$userID").get();

      return BasicUser.fromDbtoModel(document, userID);
    } catch (e) {
      return BasicUser(userID: userID);
    }
  }

  Future<List<BasicUser>> searchUserByLocation(
      {required String username}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> _searchedUsersCollections =
          await _firestoreInstance.collection("users").get();

      List<BasicUser> searchedUsers = _searchedUsersCollections.docs
          .map((data) => BasicUser.fromDbtoModel(data, data.id))
          .toList();
      List<BasicUser> filteredUsers = searchedUsers
          .where((element) => element.firstname.contains(username))
          .toList();
      print(filteredUsers);
      if (filteredUsers.isEmpty) {
        return Future.error("NO Users Found.");
      } else {
        return filteredUsers;
      }
    } catch (e) {
      return Future.error("Can't load users.");
    }
  }

  Future<List<BasicUser>> searchUserByNumberLocation(
      {required String number, required String countryCode}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> _searchedUsersCollections =
          await _firestoreInstance
              .collection("users")
              .where("phone", isEqualTo: countryCode + number)
              .get();

      List<BasicUser> searchedUsers = _searchedUsersCollections.docs
          .map((data) => BasicUser.fromDbtoModel(data, data.id))
          .toList();
      if (searchedUsers.isEmpty) {
        return Future.error("No User Found.");
      } else {
        return [searchedUsers.first];
      }
    } catch (e) {
      return Future.error("Can't load user.");
    }
  }

  updateUserAddress({required String userID, required String address}) async {
    try {
      await _firestoreInstance
          .collection("users")
          .doc(userID)
          .update({"address": address});
    } catch (e) {}
  }

  Future<List<BasicUser>> discoverPeople() async {
    try {
      QuerySnapshot<Map<String, dynamic>> _searchedUsersCollections =
          await _firestoreInstance.collection("users").limit(10).get();

      List<BasicUser> searchedUsers = _searchedUsersCollections.docs
          .map((data) => BasicUser.fromDbtoModel(data, data.id))
          .toList();
      if (searchedUsers.isEmpty) {
        return Future.error("No People Found.");
      } else {
        return searchedUsers;
      }
    } catch (e) {
      return Future.error("Failed to connect to server.");
    }
  }

  addDefaultsAdsIntoUser({required String userId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> _adsCollection =
          await _firestoreInstance.collection("adsDefaults").get();

      List<DefaultAdsModel> adsList = _adsCollection.docs
          .map((data) => DefaultAdsModel.fromDbtoModel(data))
          .toList();
      if (adsList.isEmpty) {
        return Future.error("No Ads Found.");
      } else {
        List<AdsModel> userAdsModel = adsList
            .map((data) => AdsModel(
                status: false,
                dateTime: FieldValue.serverTimestamp().toString()))
            .toList();
        addListOfAds(listOfAdsModel: userAdsModel, userId: userId);
      }
    } catch (e) {
      return Future.error("Can't load ads.");
    }
  }

  addListOfAds(
      {required String userId, required List<AdsModel> listOfAdsModel}) async {
    try {
      CollectionReference _adsCollection =
          _firestoreInstance.collection("users").doc(userId).collection("ads");
      for (AdsModel adModel in listOfAdsModel) {
        _adsCollection
            .doc(adModel.id)
            .set(adModel.toMapForDb())
            .then((value) => print("Ad Model Added!"))
            .catchError((error) => print("Error: " + error.toString()));
      }
    } catch (e) {
      return Future.error("Ads Add Failed");
    }
  }

  Future<List<AdsModel>> getUserAds({required String userId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> _adsCollection =
          await _firestoreInstance
              .collection("users")
              .doc(userId)
              .collection("ads")
              .get();
      if (_adsCollection.docs.isEmpty) {
        addDefaultsAdsIntoUser(userId: userId);
      }

      List<AdsModel> adsList = _adsCollection.docs
          .map((data) => AdsModel.fromDbtoModel(data, data.id))
          .toList();
      if (adsList.isEmpty) {
        return Future.error("No User Found.");
      } else {
        return adsList;
      }
    } catch (e) {
      return Future.error("Can't load user.");
    }
  }

  Future<bool> updateUserAds(
      {required String userID, required AdsModel adsModel}) async {
    try {
      bool isUpdated = false;
      await _firestoreInstance
          .collection("users")
          .doc(userID)
          .collection("ads")
          .doc(adsModel.id)
          .update(adsModel.toMapForDb())
          .whenComplete(() => isUpdated = true);
      return isUpdated;
    } catch (e) {
      return Future.error("User Ad Update Failed.");
    }
  }

  reportContact({required String userID, required String phoneNumber}) async {
    try {} catch (e) {}
  }

  Future<SpamModel?> checkContactAsSpam({required String phoneNumber}) async {
    try {
      print(phoneNumber);
      QuerySnapshot<Map<String, dynamic>> queryContacts =
          await _firestoreInstance
              .collection("spams")
              .where("phone", isEqualTo: phoneNumber)
              .get();
      if (queryContacts.docs.length != 0) {
        print("matched");
        SpamModel spamModel = queryContacts.docs
            .map((contact) => SpamModel.fromDbtoModel(contact, contact.id))
            .toList()
            .first;
        print(spamModel.docID);
        return spamModel;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<SpamModel>> getAllUserSpams(
      {required Iterable<Contact> listOfContacts}) async {
    try {
      List<SpamModel> newList = [];
      for (var contact in listOfContacts.toList()) {
        try {
          if (contact.phones != null) {
            QuerySnapshot<Map<String, dynamic>> queryContacts =
                await _firestoreInstance
                    .collection("spams")
                    .where("phone",
                        isEqualTo: contact.phones!.first.value!
                            .toString()
                            .replaceAll("-", "")
                            .replaceAll("+", ""))
                    .get();

            if (queryContacts.docs.isNotEmpty) {
              print("matched");
              SpamModel spamModel = queryContacts.docs
                  .map(
                      (contact) => SpamModel.fromDbtoModel(contact, contact.id))
                  .toList()
                  .first;
              print(spamModel.docID);
              newList.add(spamModel);
              print(newList);
            }
          }
        } catch (e) {}
      }
      print(newList);
      return newList;
    } catch (e) {
      return Future.error("Spams Load Failed");
    }
  }
}
