import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  int? id;
  String? name;
  String? description;
  int? price;
  String? photo;
  bool? favorite;
  bool? confirmed;
  int? store;
  int? category;
  List<int>? tag;

  Meal(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.photo,
      this.favorite,
      this.confirmed,
      this.store,
      this.category,
      this.tag});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  toJson() => _$MealToJson(this);
}
