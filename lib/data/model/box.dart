import 'meal.dart';

class Box {
  int? id;
  String? name;
  String? description;
  bool? defined;
  bool? sold;
  int? store;
  int? saleDay;
  List<Meal>? meals;

  Box({this.id, this.name, this.description, this.defined, this.sold, this.store, this.saleDay, this.meals});

  Box.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    defined = json['defined'];
    sold = json['sold'];
    store = json['store'];
    saleDay = json['sale_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['defined'] = this.defined;
    data['sold'] = this.sold;
    data['store'] = this.store;
    data['sale_day'] = this.saleDay;
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
