// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) =>
    Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  Notification({
    this.id,
    this.name,
    this.registrationId,
    this.deviceId,
    this.active,
    this.dateCreated,
    this.type,
  });

  int? id;
  dynamic name;
  String? registrationId;
  dynamic deviceId;
  bool? active;
  DateTime? dateCreated;
  String? type;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        name: json["name"],
        registrationId: json["registration_id"],
        deviceId: json["device_id"],
        active: json["active"],
        dateCreated: DateTime.parse(json["date_created"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "registration_id": registrationId,
        "device_id": deviceId,
        "active": active,
        "date_created": dateCreated!.toIso8601String(),
        "type": type,
      };
}
