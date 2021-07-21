import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'package:realcallerapp/repositories/firebase_repository/firebase_storage_repo.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';
import 'package:realcallerapp/repositories/phone_auth_repository.dart';

class BlankPage extends StatefulWidget {
  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  FirebaseStorageRepo _firebaseStorageRepo = FirebaseStorageRepo();
  PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();
  FirestoreRepo _firestoreRepo = FirestoreRepo();
  late String userID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userID = _phoneAuthRepository.getLoggedInUserID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<BasicUser>(
              future: _firestoreRepo.getUserData(userID),
              builder:
                  (BuildContext context, AsyncSnapshot<BasicUser> snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Logged In"),
                    Text("UserID: $userID"),
                    Text(
                        "Username: ${snapshot.data?.firstname} ${snapshot.data?.lastname}"),
                    Text("Email: ${snapshot.data?.email}"),
                    Text("Website: ${snapshot.data?.website}"),
                    Text("Address: ${snapshot.data?.address}")
                  ],
                );
              }),
        ),
      ),
    );
  }
}
