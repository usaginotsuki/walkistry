// To parse this JSON data, do
//
//     final friendshipList = friendshipListFromJson(jsonString);

import 'dart:convert';

FriendshipList friendshipListFromJson(String str) =>
    FriendshipList.fromJson(json.decode(str));

String friendshipListToJson(FriendshipList data) => json.encode(data.toJson());

class FriendshipList {
  FriendshipList({
    this.clientId,
    this.accountId,
    this.friendId,
  });

  String? clientId;
  String? accountId;
  List<String>? friendId;

  factory FriendshipList.fromJson(Map<String, dynamic> json) => FriendshipList(
        clientId: json["client_id"],
        accountId: json["account_id"],
        friendId: List<String>.from(json["friend_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "account_id": accountId,
        "friend_id": List<dynamic>.from(friendId!.map((x) => x)),
      };
}
