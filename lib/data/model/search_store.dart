// To parse this JSON data, do
//
//     final searchStore = searchStoreFromJson(jsonString);

import 'dart:convert';

class SearchStore {
  SearchStore({
    this.id,
    this.calendar,
    this.review,
    this.favoritedBy,
    this.packageSettings,
    this.storeMeals,
    this.categories,
    this.isCourierAvailable,
    this.distanceFromStore,
    this.storeOwner,
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
    this.deliveryType,
    this.cost,
    this.refCode,
    this.isVoted,
    this.user,
    this.boxes,
  });

  int? id;
  List<Calendar>? calendar;
  List<Review>? review;
  List<StoreOwner>? favoritedBy;
  PackageSettings? packageSettings;
  List<StoreMeal>? storeMeals;
  List<Category>? categories;
  String? isCourierAvailable;
  String? distanceFromStore;
  StoreOwner? storeOwner;
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

  String? deliveryType;
  int? cost;
  int? refCode;

  bool? isVoted;
  int? user;

  List<int>? boxes;

  factory SearchStore.fromRawJson(String str) =>
      SearchStore.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchStore.fromJson(Map<String, dynamic> json) => SearchStore(
        id: json["id"],
        calendar: json["calendar"] == null
            ? null
            : List<Calendar>.from(
                json["calendar"].map((x) => Calendar.fromJson(x))),
        review: json["review"] == null
            ? null
            : List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
/*         favoritedBy: json["favorited_by"] == null
            ? null
            : List<StoreOwner>.from(
                json["favorited_by"].map((x) => StoreOwner.fromJson(x))), */
        packageSettings: json["package_settings"] == null
            ? null
            : PackageSettings.fromJson(json["package_settings"]),
        storeMeals: json["store_meals"] == null
            ? null
            : List<StoreMeal>.from(
                json["store_meals"].map((x) => StoreMeal.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        isCourierAvailable: json["is_courier_available"] == null
            ? null
            : json["is_courier_available"],
        distanceFromStore: json["distance_from_store"] == null
            ? null
            : json["distance_from_store"],
/*         storeOwner: json["store_owner"] == null
            ? null
            : StoreOwner.fromJson(json["store_owner"]), */
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
        background: json["background"] == null ? null : json["background"],
        description: json["description"] == null ? null : json["description"],
        joinedTime: json["joined_time"] == null
            ? null
            : DateTime.parse(json["joined_time"]),
        address: json["address"] == null ? null : json["address"],
        postCode: json["post_code"] == null ? null : json["post_code"],
        city: json["city"] == null ? null : json["city"],
        province: json["province"] == null ? null : json["province"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        phoneNumber2:
            json["phone_number_2"] == null ? null : json["phone_number_2"],
        email: json["email"] == null ? null : json["email"],
        websiteLink: json["website_link"] == null ? null : json["website_link"],
        status: json["status"],
        cancelCount: json["cancel_count"] == null ? null : json["cancel_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        avgReview:
            json["avg_review"] == null ? null : json["avg_review"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        deliveryType:
            json["delivery_type"] == null ? null : json["delivery_type"],
        cost: json["cost"] == null ? null : json["cost"],
        refCode: json["ref_code"] == null ? null : json["ref_code"],
        isVoted: json["is_voted"] == null ? null : json["is_voted"],
        user: json["user"] == null ? null : json["user"],
        boxes: json["boxes"] == null
            ? null
            : List<int>.from(json["boxes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_settings":
            packageSettings == null ? null : packageSettings!.toJson(),
        "is_courier_available":
            isCourierAvailable == null ? null : isCourierAvailable,
        "distance_from_store":
            distanceFromStore == null ? null : distanceFromStore,
        "store_owner": storeOwner == null ? null : storeOwner!.toJson(),
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
        "background": background == null ? null : background,
        "description": description == null ? null : description,
        "joined_time":
            joinedTime == null ? null : joinedTime!.toIso8601String(),
        "address": address == null ? null : address,
        "post_code": postCode == null ? null : postCode,
        "city": city == null ? null : city,
        "province": province == null ? null : province,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "phone_number_2": phoneNumber2 == null ? null : phoneNumber2,
        "email": email == null ? null : email,
        "website_link": websiteLink == null ? null : websiteLink,
        "status": status,
        "cancel_count": cancelCount == null ? null : cancelCount,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "avg_review": avgReview == null ? null : avgReview,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "delivery_type": deliveryType == null ? null : deliveryType,
        "cost": cost == null ? null : cost,
        "ref_code": refCode == null ? null : refCode,
        "is_voted": isVoted == null ? null : isVoted,
        "user": user == null ? null : user,
      };
}

class Calendar {
  Calendar({
    this.id,
    this.startDate,
    this.endDate,
    this.store,
    this.isActive,
    this.boxCount,
    this.detail,
  });

  int? id;
  String? startDate;
  String? endDate;
  int? store;

  bool? isActive;
  int? boxCount;
  String? detail;

  factory Calendar.fromRawJson(String str) =>
      Calendar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        id: json["id"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        endDate: json["detail"] == null ? null : json["detail"],
        store: json["store"],
        isActive: json["is_active"],
        boxCount: json["box_count"],
        detail: json["detail"] == null ? null : json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate,
        "end_date": endDate,
        "store": store,
        "is_active": isActive,
        "box_count": boxCount,
        "detail": detail == null ? null : detail,
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.store,
  });

  int? id;
  int? name;
  int? store;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        store: json["store"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "store": store,
      };
}

class StoreOwner {
  StoreOwner({
    this.id,
  });

  int? id;

  factory StoreOwner.fromRawJson(String str) =>
      StoreOwner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreOwner.fromJson(Map<String, dynamic> json) => StoreOwner(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class PackageSettings {
  PackageSettings({
    this.id,
    this.deliveryType,
    this.ekstraAddress,
    this.deliveryTimeStart,
    this.deliveryTimeEnd,
    this.courierDeliveryTimeStart,
    this.courierDeliveryTimeEnd,
    this.openBuffet,
    this.minOrderPrice,
    this.minDiscountedOrderPrice,
    this.defaultBoxCount,
    this.packagingType,
    this.store,
  });

  int? id;
  String? deliveryType;
  String? ekstraAddress;
  String? deliveryTimeStart;
  String? deliveryTimeEnd;
  String? courierDeliveryTimeStart;
  String? courierDeliveryTimeEnd;
  bool? openBuffet;

  int? minOrderPrice;
  int? minDiscountedOrderPrice;
  int? defaultBoxCount;
  int? packagingType;
  int? store;

  factory PackageSettings.fromRawJson(String str) =>
      PackageSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageSettings.fromJson(Map<String, dynamic> json) =>
      PackageSettings(
        id: json["id"],
        deliveryType: json["delivery_type"],
        ekstraAddress: json["ekstra_address"],
        deliveryTimeStart: json["delivery_time_start"],
        deliveryTimeEnd: json["delivery_time_end"],
        courierDeliveryTimeStart: json["courier_delivery_time_start"],
        courierDeliveryTimeEnd: json["courier_delivery_time_end"],
        openBuffet: json["open_buffet"],
        minOrderPrice: json["min_order_price"],
        minDiscountedOrderPrice: json["min_discounted_order_price"],
        defaultBoxCount: json["default_box_count"],
        packagingType: json["packaging_type"],
        store: json["store"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_type": deliveryType,
        "ekstra_address": ekstraAddress,
        "delivery_time_start": deliveryTimeStart,
        "delivery_time_end": deliveryTimeEnd,
        "courier_delivery_time_start": courierDeliveryTimeStart,
        "courier_delivery_time_end": courierDeliveryTimeEnd,
        "open_buffet": openBuffet,
        "min_order_price": minOrderPrice,
        "min_discounted_order_price": minDiscountedOrderPrice,
        "default_box_count": defaultBoxCount,
        "packaging_type": packagingType,
        "store": store,
      };
}

class Review {
  Review({
    this.mealPoint,
    this.servicePoint,
    this.qualityPoint,
    this.user,
  });

  int? mealPoint;
  int? servicePoint;
  int? qualityPoint;
  User? user;

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        mealPoint: json["meal_point"],
        servicePoint: json["service_point"],
        qualityPoint: json["quality_point"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "meal_point": mealPoint,
        "service_point": servicePoint,
        "quality_point": qualityPoint,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.email,
    this.firstName,
    this.lastName,
    this.isActive,
    this.isStaff,
    this.activeAddress,
    this.createdAt,
    this.status,
    this.phoneNumber,
    this.allowEmail,
    this.allowPhone,
    this.isDeleted,
    this.deletionReason,
    this.groups,
  });

  int? id;
  String? password;
  DateTime? lastLogin;
  bool? isSuperuser;
  String? email;

  String? firstName;
  String? lastName;
  bool? isActive;
  bool? isStaff;
  int? activeAddress;
  DateTime? createdAt;
  String? status;

  String? phoneNumber;
  bool? allowEmail;
  bool? allowPhone;
  bool? isDeleted;
  String? deletionReason;

  List<int>? groups;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isActive: json["is_active"],
        isStaff: json["is_staff"],
        activeAddress:
            json["active_address"] == null ? null : json["active_address"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        phoneNumber: json["phone_number"],
        allowEmail: json["allow_email"],
        allowPhone: json["allow_phone"],
        isDeleted: json["is_deleted"],
        deletionReason: json["deletion_reason"],
        groups: List<int>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin == null ? null : lastLogin!.toIso8601String(),
        "is_superuser": isSuperuser,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "is_active": isActive,
        "is_staff": isStaff,
        "active_address": activeAddress == null ? null : activeAddress,
        "created_at": createdAt!.toIso8601String(),
        "status": status,
        "phone_number": phoneNumber,
        "allow_email": allowEmail,
        "allow_phone": allowPhone,
        "is_deleted": isDeleted,
        "deletion_reason": deletionReason,
        "groups": List<int>.from(groups!.map((x) => x)),
      };
}

class StoreMeal {
  StoreMeal({
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
  String? photo;
  bool? favorite;
  int? store;
  int? category;
  List<int>? tag;

  factory StoreMeal.fromRawJson(String str) =>
      StoreMeal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreMeal.fromJson(Map<String, dynamic> json) => StoreMeal(
        id: json["id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"],
        photo: json["photo"] == null ? null : json["photo"],
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
        "photo": photo == null ? null : photo,
        "favorite": favorite,
        "store": store,
        "category": category,
      };
}
