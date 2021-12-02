// To parse this JSON data, do
//
//     final categoryName = categoryNameFromJson(jsonString);

import 'dart:convert';

class CategoryName {
  CategoryName({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory CategoryName.fromRawJson(String str) =>
      CategoryName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryName.fromJson(Map<String, dynamic> json) => CategoryName(
        count: json["count"],
        next: json["next"] ?? '',
        previous: json["previous"] ?? '',
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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
    this.name,
    this.photo,
    this.color,
  });

  int? id;
  String? name;
  String? photo;
  String? color;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "color": color,
      };
}
