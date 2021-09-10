import 'package:json_annotation/json_annotation.dart';

import 'meal.dart';

part 'box.g.dart';

@JsonSerializable()
class Box {
  int? id;
  List<int>? meals;
  String? text_name;
  String? description;
  bool? defined;
  bool? sold;
  int? store;
  int? sale_day;

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
