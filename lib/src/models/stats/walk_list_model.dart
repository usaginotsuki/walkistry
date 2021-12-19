// To parse this JSON data, do
//
//     final walkList = walkListFromJson(jsonString);

import 'dart:convert';

List<WalkList> walkListFromJson(String str) =>
    List<WalkList>.from(json.decode(str).map((x) => WalkList.fromJson(x)));

String walkListToJson(List<WalkList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalkList {
  WalkList({
    this.finishingPoint,
    this.time,
    this.startingPoint,
    this.date,
    this.meters,
    this.segments,
  });

  IngPoint? finishingPoint;
  double? time;
  IngPoint? startingPoint;
  Date? date;
  int? meters;
  List<String>? segments;

  factory WalkList.fromJson(Map<String, dynamic> json) => WalkList(
        finishingPoint: IngPoint.fromJson(json["finishing_point"]),
        time: json["time"].toDouble(),
        startingPoint: IngPoint.fromJson(json["starting_point"]),
        date: Date.fromJson(json["date"]),
        meters: json["meters"],
        segments: List<String>.from(json["segments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "finishing_point": finishingPoint!.toJson(),
        "time": time,
        "starting_point": startingPoint!.toJson(),
        "date": date!.toJson(),
        "meters": meters,
        "segments": List<dynamic>.from(segments!.map((x) => x)),
      };
}

class Date {
  Date({
    this.seconds,
    this.nanoseconds,
  });

  DateTime? seconds;
  int? nanoseconds;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        seconds: DateTime.fromMillisecondsSinceEpoch(json["_seconds"] * 1000),
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}

class IngPoint {
  IngPoint({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory IngPoint.fromJson(Map<String, dynamic> json) => IngPoint(
        latitude: json["_latitude"].toDouble(),
        longitude: json["_longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_latitude": latitude,
        "_longitude": longitude,
      };
}
