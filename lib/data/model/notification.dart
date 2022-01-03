// To parse this JSON data, do
//
//     final myNotification = myNotificationFromJson(jsonString);

import 'dart:convert';

MyNotification myNotificationFromJson(String str) =>
    MyNotification.fromJson(json.decode(str));

String myNotificationToJson(MyNotification data) => json.encode(data.toJson());

class MyNotification {
  MyNotification({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory MyNotification.fromJson(Map<String, dynamic> json) => MyNotification(
        count: json["count"] ?? 0,
        next: json["next"] ?? '',
        previous: json["previous"] ?? '',
        results: 
            List<Result>.from(json["results"] .map((x) => Result.fromJson(x))).toList() ,
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.type,
    this.notifiedBy,
    this.isRead,
    this.message,
    this.description,
    this.date,
    this.time,
    this.timeDifference,
  });

  int? id;
  int? type;
  String? notifiedBy;
  bool? isRead;
  String? message;
  String? description;
  DateTime? date;
  String? time;
  String? timeDifference;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] ?? '',
        type: json["type"] ?? '',
        notifiedBy: json["notified_by"] ?? '',
        isRead: json["is_read"] ?? '',
        message: json["message"] ?? '',
        description: json["description"] ?? '',
        date: DateTime.parse(json["date"] ?? '') ,
        time: json["time"] ?? '',
        timeDifference: json["time_difference"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notified_by": notifiedBy,
        "is_read": isRead,
        "message": message,
        "description": description,
        "date":
           date== null  ? null : date,
        "time": time == null ? null : time,
        "time_difference":  timeDifference == null ? null : timeDifference,
      };
}
