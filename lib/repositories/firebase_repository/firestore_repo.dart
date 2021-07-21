import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:realcallerapp/models/basicuser.dart';

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
}
