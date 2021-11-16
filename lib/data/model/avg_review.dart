// To parse this JSON data, do
//
//     final avgReview = avgReviewFromJson(jsonString);

import 'dart:convert';

class AvgReview {
  AvgReview({
    this.id,
    this.mealPoint,
    this.servicePoint,
    this.qualityPoint,
    this.order,
    this.user,
    this.store,
  });

  int? id;
  int? mealPoint;
  int? servicePoint;
  int? qualityPoint;
  int? order;
  int? user;
  int? store;

  factory AvgReview.fromRawJson(String str) =>
      AvgReview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AvgReview.fromJson(Map<String, dynamic> json) => AvgReview(
        id: json["id"],
        mealPoint: json["meal_point"],
        servicePoint: json["service_point"],
        qualityPoint: json["quality_point"],
        order: json["order"],
        user: json["user"],
        store: json["store"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meal_point": mealPoint,
        "service_point": servicePoint,
        "quality_point": qualityPoint,
        "order": order,
        "user": user,
        "store": store,
      };
}
