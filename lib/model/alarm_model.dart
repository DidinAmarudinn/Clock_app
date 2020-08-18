import 'package:flutter/cupertino.dart';

class AlarmModel {
  int id;
  String title;
  DateTime alarmDateTime;
  int isPending;
  int gradientColorIndex;

  AlarmModel(
      {this.id,
      this.title,
      this.alarmDateTime,
      this.isPending,
      this.gradientColorIndex});

  factory AlarmModel.fromMap(Map<String, dynamic> json) => AlarmModel(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
