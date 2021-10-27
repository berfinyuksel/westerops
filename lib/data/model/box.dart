// To parse this JSON data, do
//
//     final box = boxFromJson(jsonString);

import 'dart:convert';

class Box {
  Box({
    this.id,
    this.saleDay,
    this.meals,
    this.description,
    this.defined,
    this.sold,
    this.textName,
    this.name,
    this.store,
  });

  int? id;
  SaleDay? saleDay;
  List<Meal>? meals;
  dynamic description;
  bool? defined;
  bool? sold;
  String? textName;
  int? name;
  int? store;

  factory Box.fromRawJson(String str) => Box.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Box.fromJson(Map<String, dynamic> json) => Box(
        id: json["id"],
        saleDay: SaleDay.fromJson(json["sale_day"]),
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
        description: json["description"],
        defined: json["defined"],
        sold: json["sold"],
        textName: json["text_name"],
        name: json["name"],
        store: json["store"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sale_day": saleDay!.toJson(),
        "meals": List<dynamic>.from(meals!.map((x) => x.toJson())),
        "description": description,
        "defined": defined,
        "sold": sold,
        "text_name": textName,
        "name": name,
        "store": store,
      };
}

class Meal {
  Meal({
    this.id,
    this.name,
    this.description,
    this.price,
    this.photo,
    this.favorite,
    this.store,
    this.category,
    this.tag,
  });

  int? id;
  String? name;
  String? description;
  int? price;
  dynamic photo;
  bool? favorite;
  int? store;
  int? category;
  List<int>? tag;

  factory Meal.fromRawJson(String str) => Meal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json["id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"],
        photo: json["photo"],
        favorite: json["favorite"],
        store: json["store"],
        category: json["category"],
        tag: List<int>.from(json["tag"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description == null ? null : description,
        "price": price,
        "photo": photo,
        "favorite": favorite,
        "store": store,
        "category": category,
        "tag": List<dynamic>.from(tag!.map((x) => x)),
      };
}

class SaleDay {
  SaleDay({
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
  dynamic timeLabel;
  bool? isActive;
  int? boxCount;
  String? detail;

  factory SaleDay.fromRawJson(String str) => SaleDay.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleDay.fromJson(Map<String, dynamic> json) => SaleDay(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        store: json["store"],
        timeLabel: json["time_label"],
        isActive: json["is_active"],
        boxCount: json["box_count"],
        detail: json["detail"] == null ? null : json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "store": store,
        "time_label": timeLabel,
        "is_active": isActive,
        "box_count": boxCount,
        "detail": detail == null ? null : detail,
      };
}
