// To parse this JSON data, do
//
//     final groups = groupsFromJson(jsonString);

import 'dart:convert';

Groups groupsFromJson(String str) => Groups.fromJson(json.decode(str));

String groupsToJson(Groups data) => json.encode(data.toJson());

class Groups {
  Groups({
    this.groupId,
    this.accountId,
    this.creationDate,
    this.exerciseTarget,
    this.groupLevel,
  });

  int? groupId;
  List<String>? accountId;
  DateTime? creationDate;
  int? exerciseTarget;
  int? groupLevel;

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        groupId: json["group_id"],
        accountId: List<String>.from(json["account_id"].map((x) => x)),
        creationDate: DateTime.parse(json["creation_date"]),
        exerciseTarget: json["exercise_target"],
        groupLevel: json["group_level"],
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "account_id": List<dynamic>.from(accountId!.map((x) => x)),
        "creation_date": creationDate!.toIso8601String(),
        "exercise_target": exerciseTarget,
        "group_level": groupLevel,
      };
}
