// To parse this JSON data, do
//
//     final authToken = authTokenFromJson(jsonString);

import 'dart:convert';

AuthToken authTokenFromJson(String str) => AuthToken.fromJson(json.decode(str));

String authTokenToJson(AuthToken data) => json.encode(data.toJson());

class AuthToken {
  AuthToken({
    this.authToken,
  });

  String? authToken;

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
        authToken: json["auth_token"],
      );

  Map<String, dynamic> toJson() => {
        "auth_token": authToken,
      };
}
