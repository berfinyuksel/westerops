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

  Meal({this.id, this.name, this.description, this.price, this.photo, this.favorite, this.confirmed, this.store, this.category, this.tag});

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    photo = json['photo'];
    favorite = json['favorite'];
    confirmed = json['confirmed'];
    store = json['store'];
    category = json['category'];
    tag = json['tag'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['favorite'] = this.favorite;
    data['confirmed'] = this.confirmed;
    data['store'] = this.store;
    data['category'] = this.category;
    data['tag'] = this.tag;
    return data;
  }
}
