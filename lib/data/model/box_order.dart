// To parse this JSON data, do
//
//     final BoxOrder = BoxOrderFromJson(jsonString);

import 'dart:convert';

class BoxOrder {
  BoxOrder({
    this.id,
    this.packageSetting,
    this.description,
    this.defined,
    this.sold,
    this.textName,
    this.name,
    this.store,
    this.saleDay,
    this.meals,
  });

  int? id;
  PackageSetting? packageSetting;
  dynamic description;
  bool? defined;
  bool? sold;
  String? textName;
  Name? name;
  Store? store;
  SaleDay? saleDay;
  List<dynamic>? meals;

  factory BoxOrder.fromRawJson(String str) =>
      BoxOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BoxOrder.fromJson(Map<String, dynamic> json) => BoxOrder(
        id: json["id"],
        packageSetting: PackageSetting.fromJson(json["package_setting"]),
        description: json["description"],
        defined: json["defined"],
        sold: json["sold"],
        textName: json["text_name"],
        name: Name.fromJson(json["name"]),
        store: Store.fromJson(json["store"]),
        saleDay: SaleDay.fromJson(json["sale_day"]),
        meals: List<dynamic>.from(json["meals"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_setting": packageSetting!.toJson(),
        "description": description,
        "defined": defined,
        "sold": sold,
        "text_name": textName,
        "name": name!.toJson(),
        "store": store!.toJson(),
        "sale_day": saleDay!.toJson(),
        "meals": List<dynamic>.from(meals!.map((x) => x)),
      };
}

class Name {
  Name({
    this.id,
    this.name,
    this.confirmed,
    this.store,
  });

  int? id;
  String? name;
  bool? confirmed;
  int? store;

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        id: json["id"],
        name: json["name"],
        confirmed: json["confirmed"],
        store: json["store"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "confirmed": confirmed,
        "store": store,
      };
}

class PackageSetting {
  PackageSetting({
    this.minDiscountedOrderPrice,
    this.minOrderPrice,
  });

  int? minDiscountedOrderPrice;
  int? minOrderPrice;

  factory PackageSetting.fromRawJson(String str) =>
      PackageSetting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageSetting.fromJson(Map<String, dynamic> json) => PackageSetting(
        minDiscountedOrderPrice: json["min_discounted_order_price"],
        minOrderPrice: json["min_order_price"],
      );

  Map<String, dynamic> toJson() => {
        "min_discounted_order_price": minDiscountedOrderPrice,
        "min_order_price": minOrderPrice,
      };
}

class SaleDay {
  SaleDay({
    this.id,
    this.startDate,
    this.endDate,
    this.boxCount,
    this.detail,
    this.isActive,
    this.boxCreateTaskId,
    this.createdAt,
    this.updatedAt,
    this.store,
    this.timeLabel,
  });

  int? id;
  DateTime? startDate;
  DateTime? endDate;
  int? boxCount;
  String? detail;
  bool? isActive;
  String? boxCreateTaskId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? store;
  dynamic timeLabel;

  factory SaleDay.fromRawJson(String str) => SaleDay.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleDay.fromJson(Map<String, dynamic> json) => SaleDay(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        boxCount: json["box_count"],
        detail: json["detail"],
        isActive: json["is_active"],
        boxCreateTaskId: json["box_create_task_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        store: json["store"],
        timeLabel: json["time_label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "box_count": boxCount,
        "detail": detail,
        "is_active": isActive,
        "box_create_task_id": boxCreateTaskId,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "store": store,
        "time_label": timeLabel,
      };
}

class Store {
  Store({
    this.id,
    this.name,
    this.photo,
    this.background,
    this.description,
    this.joinedTime,
    this.address,
    this.postCode,
    this.city,
    this.province,
    this.phoneNumber,
    this.phoneNumber2,
    this.email,
    this.websiteLink,
    this.status,
    this.cancelCount,
    this.createdAt,
    this.avgReview,
    this.latitude,
    this.longitude,
    this.storeOwner,
    this.favoritedBy,
  });

  int? id;
  String? name;
  String? photo;
  String? background;
  String? description;
  DateTime? joinedTime;
  String? address;
  String? postCode;
  String? city;
  String? province;
  String? phoneNumber;
  String? phoneNumber2;
  String? email;
  String? websiteLink;
  String? status;
  int? cancelCount;
  DateTime? createdAt;
  double? avgReview;
  double? latitude;
  double? longitude;
  int? storeOwner;
  List<dynamic>? favoritedBy;

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        background: json["background"],
        description: json["description"],
        joinedTime: DateTime.parse(json["joined_time"]),
        address: json["address"],
        postCode: json["post_code"],
        city: json["city"],
        province: json["province"],
        phoneNumber: json["phone_number"],
        phoneNumber2: json["phone_number_2"],
        email: json["email"],
        websiteLink: json["website_link"],
        status: json["status"],
        cancelCount: json["cancel_count"],
        createdAt: DateTime.parse(json["created_at"]),
        avgReview: json["avg_review"].toDouble(),
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        storeOwner: json["store_owner"],
        favoritedBy: List<dynamic>.from(json["favorited_by"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "background": background,
        "description": description,
        "joined_time": joinedTime!.toIso8601String(),
        "address": address,
        "post_code": postCode,
        "city": city,
        "province": province,
        "phone_number": phoneNumber,
        "phone_number_2": phoneNumber2,
        "email": email,
        "website_link": websiteLink,
        "status": status,
        "cancel_count": cancelCount,
        "created_at": createdAt!.toIso8601String(),
        "avg_review": avgReview,
        "latitude": latitude,
        "longitude": longitude,
        "store_owner": storeOwner,
        "favorited_by": List<dynamic>.from(favoritedBy!.map((x) => x)),
      };
}
