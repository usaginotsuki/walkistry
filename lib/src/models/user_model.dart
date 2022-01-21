// To parse this JSON data, do
//
//     final User = UserFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

User UserFromJson(String str) => User.fromJson(json.decode(str));

String UserToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {this.weight,
      this.weigthTarget,
      this.dateOfBirth,
      this.height,
      this.name,
      this.exerciseTarget,
      this.avatar,
      this.background});

  int? weight;
  int? weigthTarget;
  DateOfBirth? dateOfBirth;
  int? height;
  String? name;
  int? exerciseTarget;
  String? avatar;
  String? background;

  factory User.fromJson(Map<String, dynamic> json) => User(
        weight: json["weight"],
        weigthTarget: json["weigthTarget"],
        dateOfBirth: DateOfBirth.fromJson(json["dateOfBirth"]),
        height: json["height"],
        name: json["name"],
        exerciseTarget: json["exerciseTarget"],
        avatar: json["avatar"],
        background: json["background"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "weigthTarget": weigthTarget,
        "dateOfBirth": dateOfBirth!.toJson(),
        "height": height,
        "name": name,
        "exerciseTarget": exerciseTarget,
      };
}

class DateOfBirth {
  DateOfBirth({
    this.seconds,
    this.nanoseconds,
  });

  DateTime? seconds;
  int? nanoseconds;

  factory DateOfBirth.fromJson(Map<String, dynamic> json) => DateOfBirth(
        seconds: DateTime.fromMillisecondsSinceEpoch(json["_seconds"] * 1000),
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds!.millisecondsSinceEpoch ~/ 1000,
        "_nanoseconds": nanoseconds,
      };
}
