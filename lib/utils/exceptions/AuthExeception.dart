class AuthException implements Exception {
  String cause;
  AuthException(this.cause);
}

class UserLogInFailed implements Exception {
  String cause;
  UserLogInFailed({this.cause = ""});
}
