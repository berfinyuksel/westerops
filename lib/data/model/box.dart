import 'package:json_annotation/json_annotation.dart';

import 'meal.dart';

part 'box.g.dart';

@JsonSerializable()
class Box {
  int? id;
  List<Meal>? meals;
  String? text_name;
  String? description;
  bool? defined;
  bool? sold;
  int? store;

  Box({
    this.id,
    this.meals,
    this.text_name,
    this.description,
    this.defined,
    this.sold,
    this.store,
  });

  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);
  toJson() => _$BoxToJson(this);
}
