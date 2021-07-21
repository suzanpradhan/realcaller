import 'package:cloud_firestore/cloud_firestore.dart';

class AdsModel {
  final String id;
  final bool status;
  final String? dateTime;

  AdsModel({required this.dateTime, required this.id, this.status = false});

  Map<String, dynamic> toMapForDb() => {
        "status": this.status,
        "dateTime": this.dateTime,
      };

  factory AdsModel.fromDbtoModel(DocumentSnapshot data, String docID) =>
      AdsModel(id: docID, status: data["status"], dateTime: data["dateTime"]);
}
