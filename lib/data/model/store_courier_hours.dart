// To parse this JSON data, do
//
//     final storeCourierHours = storeCourierHoursFromJson(jsonString);

import 'dart:convert';

class StoreCourierHours {
  StoreCourierHours({
    this.id,
    this.startDate,
    this.endDate,
    this.storeId,
    this.orderId,
    this.isAvailable,
  });

  int? id;
  DateTime? startDate;
  DateTime? endDate;
  int? storeId;
  dynamic orderId;
  bool? isAvailable;

  factory StoreCourierHours.fromRawJson(String str) =>
      StoreCourierHours.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreCourierHours.fromJson(Map<String, dynamic> json) =>
      StoreCourierHours(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        storeId: json["store_id"],
        orderId: json["order_id"],
        isAvailable: json["is_available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "store_id": storeId,
        "order_id": orderId,
        "is_available": isAvailable,
      };
}
