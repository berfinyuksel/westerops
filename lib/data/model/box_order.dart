import 'package:dongu_mobile/data/model/store.dart';
import 'package:json_annotation/json_annotation.dart';

import 'meal.dart';
part 'box_order.g.dart';

@JsonSerializable()
class BoxOrder {
  int? id;
  List<Meal>? meals;
  String? text_name;
  String? description;
  bool? defined;
  bool? sold;
  Store? store;


  BoxOrder({
    this.id,
    this.meals,
    this.text_name,
    this.description,
    this.defined,
    this.sold,
    this.store,
  });
  factory BoxOrder.fromJson(Map<String, dynamic> json) => _$BoxOrderFromJson(json);
  toJson() => _$BoxOrderToJson(this);
}
