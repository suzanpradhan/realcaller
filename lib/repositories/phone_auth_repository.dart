import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:realcallerapp/blocs/authbloc/auth_bloc.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'dart:async';

import 'package:realcallerapp/utils/exceptions/AuthExeception.dart';

class PhoneAuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future verifyPhoneNumber(BasicUser user) async {
    await this._auth.verifyPhoneNumber(
        phoneNumber: user.phone,
        verificationCompleted: (AuthCredential phoneAuthCredential) {
          this
              ._auth
              .signInWithCredential(phoneAuthCredential)
              .then((UserCredential userCredential) {
            if (userCredential.user != null) {
              throw UserLogInFailed(cause: "Sign In Failed. ::No User.");
            } else {
              return userCredential;
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            throw UserLogInFailed(
                cause: 'The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timeout");
        });
  }
}
