// To parse this JSON data, do
//
//     final UserLogin = UserLoginFromJson(jsonString);

import 'dart:convert';

UserLogin UserLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String UserLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({
    this.displayName,
    this.email,
    this.password,
  });

  String? displayName;
  String? email;
  String? password;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        displayName: json["displayName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "password": password,
      };
}
