// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.accountId,
    this.name,
    this.dateOfBirth,
    this.height,
    this.weight,
    this.exerciseTarget,
    this.weigthTarget,
  });

  String? accountId;
  String? name;
  DateTime? dateOfBirth;
  int? height;
  int? weight;
  int? exerciseTarget;
  int? weigthTarget;

  factory User.fromJson(Map<String, dynamic> json) => User(
        accountId: json["account_id"],
        name: json["name"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        height: json["height"],
        weight: json["weight"],
        exerciseTarget: json["exercise_target"],
        weigthTarget: json["weigth_target"],
      );

  Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "name": name,
        "date_of_birth": dateOfBirth!.toIso8601String(),
        "height": height,
        "weight": weight,
        "exercise_target": exerciseTarget,
        "weigth_target": weigthTarget,
      };
}
