import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';

part 'emailsignin_event.dart';
part 'emailsignin_state.dart';

class EmailsigninBloc extends Bloc<EmailsigninEvent, EmailsigninState> {
  final FirestoreRepo firestoreRepo = FirestoreRepo();
  EmailsigninBloc() : super(EmailsigninInitial());

  @override
  Stream<EmailsigninState> mapEventToState(
    EmailsigninEvent event,
  ) async* {
    if (event is EmailFormSubmitted) {
      yield* emailSignIn(email: event.email, password: event.password);
    }
  }

  Stream<EmailsigninState> emailSignIn(
      {required String email, required String password}) async* {
    try {
      yield EmailSignInLoading();
      UserCredential? userCredential = (await firestoreRepo
          .signInAccountWithEmail(email: email, password: password));
      if (userCredential != null) {
        yield EmailSignInSuccess();
      } else {
        yield EmailSignInFailed(message: "Login Failed!");
      }
    } catch (e) {
      yield EmailSignInFailed(message: e.toString());
    }
  }
}
