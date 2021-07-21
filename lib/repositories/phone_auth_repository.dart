import 'package:firebase_auth/firebase_auth.dart';
import 'package:realcallerapp/blocs/authbloc/auth_bloc.dart';
import 'dart:async';

import 'package:realcallerapp/utils/exceptions/AuthExeception.dart';

class PhoneAuthRepository {
  String _verificationID = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PhoneAuthRepository();

  bool isLoggedIn() {
    final user = _auth.currentUser; //check if user is logged in or not
    return user != null;
  }

  Future verifyPhoneNumber(
      {required String phoneNumber, required AuthBloc authBloc}) async {
    print("Verifying Phone Number");
    await this._auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 3),
        verificationCompleted: (AuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            throw UserLogInFailed(
                cause: 'The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          this._verificationID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timeout");
          this._verificationID = verificationId;
          authBloc.add(GotVerifictionCodeEvent(verificationID: verificationId));
        });
  }

  String getVerificationID() {
    return _verificationID;
  }

  String getLoggedInUserID() {
    return _auth.currentUser!.uid;
  }

  String getLoggedInUserPhoneNumber() {
    if (_auth.currentUser!.phoneNumber != null) {
      return _auth.currentUser!.phoneNumber!;
    } else {
      return "";
    }
  }
}
