import 'package:cloud_firestore/cloud_firestore.dart';

class DefaultAdsModel {
  String defaultAdID;
  String name;
  String points;
  String time;

  DefaultAdsModel(
      {required this.defaultAdID,
      required this.name,
      required this.points,
      required this.time});

  factory DefaultAdsModel.fromDbtoModel(DocumentSnapshot data) =>
      DefaultAdsModel(
          defaultAdID: data.id,
          name: data["name"],
          points: data["points"],
          time: data["time"]);
}
