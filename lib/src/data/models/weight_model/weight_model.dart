import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  final String id;
  final double weightValue;

  final Timestamp timeStamp;

  WeightModel(
      {required this.weightValue, required this.timeStamp, required this.id});

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
        id: json["id"],
        weightValue: json["weightValue"],
        timeStamp: json["timestamp"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "weightValue": weightValue, "timestamp": timeStamp};
  }
}
