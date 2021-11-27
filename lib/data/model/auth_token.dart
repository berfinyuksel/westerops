// To parse this JSON data, do
//
//     final authToken = authTokenFromJson(jsonString);

import 'dart:convert';

class AuthToken {
  AuthToken({
    this.success,
    this.statusCode,
    this.message,
    this.token,
    this.user,
  });

  String? success;
  int? statusCode;
  String? message;
  String? token;
  User? user;

  factory AuthToken.fromRawJson(String str) =>
      AuthToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
        success: json["success"],
        statusCode: json["status code"],
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status code": statusCode,
        "message": message,
        "token": token,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.birthdate,
    this.stores,
    this.status,
    this.adminRole,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phoneNumber;
  DateTime? birthdate;
  dynamic stores;
  String? status;
  dynamic adminRole;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        birthdate: DateTime.parse(json["birthdate"]),
        stores: json["stores"],
        status: json["status"],
        adminRole: json["admin_role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "stores": stores,
        "status": status,
        "admin_role": adminRole,
      };
}
