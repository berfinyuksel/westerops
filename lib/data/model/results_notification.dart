// To parse this JSON data, do
//
//     final results = resultsFromJson(jsonString);

import 'dart:convert';

class Results {
  Results({
    required this.results,
  });

  final List<Result>? results;

  factory Results.fromRawJson(String str) => Results.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.type,
    this.notifiedBy,
    this.isRead,
    this.isDeleted,
    this.message,
    this.description,
    this.date,
    this.time,
    this.timeDifference,
  });

  final int? id;
  final int? type;
  final String? notifiedBy;
  final bool? isRead;
  final bool? isDeleted;
  final String? message;
  final String? description;
  final String? date;
  final String? time;
  final String? timeDifference;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        notifiedBy: json["notified_by"] == null ? null : json["notified_by"],
        isRead: json["is_read"] == null ? null : json["is_read"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        message: json["message"] == null ? null : json["message"],
        description: json["description"] == null ? null : json["description"],
        date: json["date"] == null ? null : json["date"],
        time: json["time"] == null ? null : json["time"],
        timeDifference:
            json["time_difference"] == null ? null : json["time_difference"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "notified_by": notifiedBy == null ? null : notifiedBy,
        "is_read": isRead == null ? null : isRead,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "message": message == null ? null : message,
        "description": description == null ? null : description,
        "date": date == null
            ? null
            : date,
        "time": time == null ? null : time,
        "time_difference": timeDifference == null ? null : timeDifference,
      };
}
