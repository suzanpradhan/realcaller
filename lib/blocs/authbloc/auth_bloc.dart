import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realcallerapp/repositories/phone_auth_repository.dart';
import 'package:realcallerapp/service/app_permissions.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();

  final FirestoreRepo _firestoreRepo = FirestoreRepo();
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginFromPhoneSubmitEvent) {
      // LOGIN FROM PHONE FORM SUBMITTED

      yield LoginFormSubmissionLoading();
      // CHECK INTERNET HERE

      String phoneNumberWithCountryCode =
          event.countryCode.dialCode! + event.phoneNumber;
      print(phoneNumberWithCountryCode);
      yield LoginFormSubmissionSuccess(phoneNumber: phoneNumberWithCountryCode);
      yield* loginFromPhone(
          phoneNumberWithCountryCode: phoneNumberWithCountryCode);
    } else if (event is ResendCodeVerification) {
      // RESEND CODE VERIFICATION

      yield* loginFromPhone(phoneNumberWithCountryCode: event.phoneNumber);
    } else if (event is LoadLoginFormEvent) {
      yield LoginFormLoading();
      if (_phoneAuthRepository.isLoggedIn()) {
        AppPermission appPermission = AppPermission();
        Map<Permission, PermissionStatus> status =
            await appPermission.getAllPermissionsRequests(authBloc: this);
      }
    } else if (event is PhoneNumberChanged) {
      yield* checkValidPhoneInput(phoneNumber: event.phoneNumber);
    } else if (event is VerificationCodeChanged) {
      yield* checkValidVerificationInput(code: event.code);
    } else if (event is VerificationFormLoadEvent) {
    } else if (event is VerificationCodeSubmitEvent) {
      String verificationID = _phoneAuthRepository.getVerificationID();
      yield* verifyCode(
          verificationID: verificationID, verificationCode: event.code);
    } else if (event is GotVerifictionCodeEvent) {
      // GOT VERIFICATION CODE

      print("Got Verification Code is:" + event.verificationID);
      yield VerificationCodeSendSuccess(verificationID: event.verificationID);
    } else if (event is AllPermissionGranted) {
      print("Granted!");
      yield AllPermissionGrantedState();
      bool isUserExist = await _firestoreRepo
          .checkUserExists(_phoneAuthRepository.getLoggedInUserID());
      if (isUserExist) {
        yield LoginSuccess();
      } else {
        yield LoginSuccessWithoutUser();
      }
    }
  }

  // Stream<AuthState> mapRegistrationToState(BasicUser user) async* {
  //   yield RegisterFormSubmissionSuccess();
  // }

  Stream<AuthState> checkValidPhoneInput({String? phoneNumber}) async* {
    if (phoneNumber != null && phoneNumber != "") {
      yield LoginFormActive();
    } else {
      yield LoginFormDisabled();
    }
  }

  Stream<AuthState> checkValidVerificationInput({String? code}) async* {
    if (code != null && code != "" && code.length == 6) {
      yield VerificationFormActive();
    } else {
      yield VerificationFormDisabled();
    }
  }

  Stream<AuthState> loginFromPhone(
      {required String phoneNumberWithCountryCode}) async* {
    print(phoneNumberWithCountryCode);
    yield VerificationCodeSentLoading();
    await _phoneAuthRepository.verifyPhoneNumber(
        phoneNumber: phoneNumberWithCountryCode, authBloc: this);
  }

  Stream<AuthState> verifyCode(
      {required String verificationID,
      required String verificationCode}) async* {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final PhoneAuthCredential phoneAuthCredential =
        PhoneAuthProvider.credential(
            verificationId: verificationID, smsCode: verificationCode);
    final User? user =
        (await auth.signInWithCredential(phoneAuthCredential)).user;
    // final User currentUser = auth.currentUser!;
    if (user != null) {
      print("login success");
      AppPermission appPermission = AppPermission();
      Map<Permission, PermissionStatus> status =
          await appPermission.getAllPermissionsRequests(authBloc: this);
    } else {
      print("login failed");
      yield LoginFailed();
    }
  }
}
