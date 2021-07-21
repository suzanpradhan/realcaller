import 'dart:typed_data';

class AppContact {
  // Name
  String displayName, givenName, familyName;

// Email addresses
  String emails;

// Phone numbers
  int phones;

// Post addresses
  String address;

// Contact avatar/thumbnail
  Uint8List avatar;
  AppContact(
      {required this.displayName,
      required this.givenName,
      required this.familyName,
      required this.emails,
      required this.phones,
      required this.address,
      required this.avatar});
}
