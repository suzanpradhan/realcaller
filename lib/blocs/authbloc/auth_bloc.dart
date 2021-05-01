import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/models/basicuser.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is RegistrationFormSubmitEvent) {
      yield RegisterFormSubmissionLoading();
      if (event.password == event.confirmPassword) {
        yield* mapRegistrationToState(event.user);
      } else {
        yield RegisterFormSubmissionFailed(
            errorMessage: "Password must be same.");
      }
    }
  }

  Stream<AuthState> mapRegistrationToState(BasicUser user) async* {
    yield RegisterFormSubmissionSuccess();
  }
}
