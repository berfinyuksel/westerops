// To parse this JSON data, do
//
//     final timeInterval = timeIntervalFromJson(jsonString);

import 'dart:convert';

class TimeInterval {
    TimeInterval({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    int? count;
    dynamic next;
    dynamic previous;
    List<Result>? results;

    factory TimeInterval.fromRawJson(String str) => TimeInterval.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TimeInterval.fromJson(Map<String, dynamic> json) => TimeInterval(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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
        this.startDate,
        this.endDate,
        this.store,
        this.timeLabel,
        this.isActive,
        this.boxCount,
        this.detail,
    });

    int? id;
    DateTime? startDate;
    DateTime? endDate;
    int? store;
    int? timeLabel;
    bool ?isActive;
    int ?boxCount;
    String ?detail;

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        store: json["store"],
        timeLabel: json["time_label"] == null ? null : json["time_label"],
        isActive: json["is_active"],
        boxCount: json["box_count"],
        detail: json["detail"] == null ? null : json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "store": store,
        "time_label": timeLabel == null ? null : timeLabel,
        "is_active": isActive,
        "box_count": boxCount,
        "detail": detail == null ? null : detail,
    };
}
