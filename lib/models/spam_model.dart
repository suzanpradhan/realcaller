import 'package:cloud_firestore/cloud_firestore.dart';

class SpamModel {
   String docID;
   String userID;
   String phoneNumber;
   String firstName;
   String lastname;
   int spamsReported;
   bool isSpammed;
   String timeStamp;

  SpamModel(
      {required this.docID,
      required this.firstName,
      required this.isSpammed,
      required this.lastname,
      required this.phoneNumber,
      required this.spamsReported,
      required this.userID,
      required this.timeStamp});

  Map<String, dynamic> toMapForDb() => {
        "userID": this..userID,
        "firstName": this.firstName,
        "isSpammed": this.isSpammed,
        "lastname": this.lastname,
        "phoneNumber": this.phoneNumber,
        "spamsReported": this.spamsReported
      };

  factory SpamModel.fromDbtoModel(DocumentSnapshot data, String docID) =>
      SpamModel(
          docID: docID,
          userID: data["userID"],
          firstName: data["firstname"],
          isSpammed: data["isSpammed"],
          lastname: data["lastname"],
          phoneNumber: data["phone"],
          spamsReported: data["spamsReported"],
          timeStamp: data["timeStamp"].toString());
}
