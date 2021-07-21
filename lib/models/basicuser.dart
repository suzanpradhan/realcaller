import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realcallerapp/repositories/firebase_repository/firebase_storage_repo.dart';

class BasicUser {
  String userID;
  String firstname;
  String lastname;
  String phone;
  String email;
  String website;
  String address;
  String brithday;
  String profileUrl;

  BasicUser(
      {required this.userID,
      this.firstname = "",
      this.lastname = "",
      this.phone = "",
      this.email = "",
      this.address = "",
      this.brithday = "",
      this.website = "",
      this.profileUrl = ""});
  Map<String, dynamic> toMapForDb() => {
        "firstname": this.firstname,
        "lastname": this.lastname,
        "phone": this.phone,
        "email": this.email,
        "website": this.website,
        "address": this.address,
        "coverImageUrl": this.profileUrl,
        "birthday": this.brithday
      };

  factory BasicUser.fromDbtoModel(DocumentSnapshot data, String userID) =>
      BasicUser(
          userID: userID,
          firstname: data["firstname"],
          lastname: data["lastname"],
          email: data["email"],
          phone: data["phone"],
          website: data["website"],
          address: data["address"],
          profileUrl: data["coverImageUrl"]);
}
