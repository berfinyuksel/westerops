import 'package:json_annotation/json_annotation.dart';

import 'meal.dart';

part 'box.g.dart';

@JsonSerializable()
class Box {
  int? id;
  List<Meal>? meals;
  String? name;
  String? description;
  bool? defined;
  bool? sold;
  int? store;
  int? saleDay;

  Box({
    this.id,
    this.meals,
    this.name,
    this.description,
    this.defined,
    this.sold,
    this.store,
    this.saleDay,
  });

  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);
  toJson() => _$BoxToJson(this);
}
