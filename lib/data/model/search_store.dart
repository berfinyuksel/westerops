// To parse this JSON data, do
//
//     final searchStore = searchStoreFromJson(jsonString);

import 'dart:convert';

List<List<SearchStore>> searchStoreFromJson(String str) =>
    List<List<SearchStore>>.from(json.decode(str).map(
        (x) => List<SearchStore>.from(x.map((x) => SearchStore.fromJson(x)))));

String searchStoreToJson(List<List<SearchStore>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

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

  factory SearchStore.fromJson(Map<String, dynamic> json) => SearchStore(
        id: json["id"],
        calendar: List<Calendar>.from(
            json["calendar"].map((x) => Calendar.fromJson(x))),
        review:
            List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
        favoritedBy: List<StoreOwner>.from(
            json["favorited_by"].map((x) => StoreOwner.fromJson(x))),
        packageSettings:json["package_settings"] == null ? null : PackageSettings.fromJson(json["package_settings"]),
        storeMeals: List<StoreMeal>.from(
            json["store_meals"].map((x) => StoreMeal.fromJson(x))),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        isCourierAvailable: json["is_courier_available"],
        distanceFromStore: json["distance_from_store"],
        storeOwner: StoreOwner.fromJson(json["store_owner"]),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "calendar": List<dynamic>.from(calendar!.map((x) => x.toJson())),
        "review": List<dynamic>.from(review!.map((x) => x.toJson())),
        "favorited_by": List<dynamic>.from(favoritedBy!.map((x) => x.toJson())),
        "package_settings": packageSettings?.toJson(),
        "store_meals": List<dynamic>.from(storeMeals!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "is_courier_available": isCourierAvailable,
        "distance_from_store": distanceFromStore,
        "store_owner": storeOwner?.toJson(),
        "name": name,
        "photo": photo,
        "background": background,
        "description": description,
        "joined_time": joinedTime?.toIso8601String(),
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
        "created_at": createdAt?.toIso8601String(),
        "avg_review": avgReview,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Calendar {
  Calendar({
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

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        store: json["store"],
        timeLabel: json["time_label"],
        isActive: json["is_active"],
        boxCount: json["box_count"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "store": store,
        "time_label": timeLabel,
        "is_active": isActive,
        "box_count": boxCount,
        "detail": detail,
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
    this.extraSuggestion,
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
  String? extraSuggestion;
  int? minOrderPrice;
  int? minDiscountedOrderPrice;
  int? defaultBoxCount;
  int? packagingType;
  int? store;

  factory PackageSettings.fromJson(Map<String, dynamic> json) =>
      PackageSettings(
        id: json["id"],
        deliveryType: json["delivery_type"],
        ekstraAddress:
            json["ekstra_address"] == null ? null : json["ekstra_address"],
        deliveryTimeStart: json["delivery_time_start"],
        deliveryTimeEnd: json["delivery_time_end"],
        courierDeliveryTimeStart: json["courier_delivery_time_start"] == null
            ? null
            : json["courier_delivery_time_start"],
        courierDeliveryTimeEnd: json["courier_delivery_time_end"] == null
            ? null
            : json["courier_delivery_time_end"],
        openBuffet: json["open_buffet"],
        extraSuggestion:
            json["extra_suggestion"] == null ? null : json["extra_suggestion"],
        minOrderPrice: json["min_order_price"],
        minDiscountedOrderPrice: json["min_discounted_order_price"],
        defaultBoxCount: json["default_box_count"],
        packagingType: json["packaging_type"],
        store: json["store"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_type": deliveryType,
        "ekstra_address": ekstraAddress == null ? null : ekstraAddress,
        "delivery_time_start": deliveryTimeStart,
        "delivery_time_end": deliveryTimeEnd,
        "courier_delivery_time_start":
            courierDeliveryTimeStart == null ? null : courierDeliveryTimeStart,
        "courier_delivery_time_end":
            courierDeliveryTimeEnd == null ? null : courierDeliveryTimeEnd,
        "open_buffet": openBuffet,
        "extra_suggestion": extraSuggestion == null ? null : extraSuggestion,
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
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.password,
    this.lastLogin,
    this.isSuperuser,
    this.email,
    this.facebookEmail,
    this.googleEmail,
    this.firstName,
    this.lastName,
    this.isActive,
    this.isStaff,
    this.activeAddress,
    this.createdAt,
    this.status,
    this.birthdate,
    this.phoneNumber,
    this.allowEmail,
    this.allowPhone,
    this.isDeleted,
    this.deletionReason,
    this.cardUserKey,
    this.adminRole,
    this.userPermissions,
    this.groups,
  });

  int? id;
  String? password;
  DateTime? lastLogin;
  bool? isSuperuser;
  String? email;
  dynamic facebookEmail;
  String? googleEmail;
  String? firstName;
  String? lastName;
  bool? isActive;
  bool? isStaff;
  int? activeAddress;
  DateTime? createdAt;
  String? status;
  DateTime? birthdate;
  String? phoneNumber;
  bool? allowEmail;
  bool? allowPhone;
  bool? isDeleted;
  String? deletionReason;
  String? cardUserKey;
  dynamic adminRole;
  List<dynamic>? userPermissions;
  List<int>? groups;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        email: json["email"],
        facebookEmail: json["facebook_email"],
        googleEmail: json["google_email"] == null ? null : json["google_email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isActive: json["is_active"],
        isStaff: json["is_staff"],
        activeAddress: json["active_address"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        allowEmail: json["allow_email"],
        allowPhone: json["allow_phone"],
        isDeleted: json["is_deleted"],
        deletionReason: json["deletion_reason"],
        cardUserKey: json["card_user_key"],
        adminRole: json["admin_role"],
        userPermissions:
            List<dynamic>.from(json["user_permissions"].map((x) => x)),
        groups: List<int>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin?.toIso8601String(),
        "is_superuser": isSuperuser,
        "email": email,
        "facebook_email": facebookEmail,
        "google_email": googleEmail == null ? null : googleEmail,
        "first_name": firstName,
        "last_name": lastName,
        "is_active": isActive,
        "is_staff": isStaff,
        "active_address": activeAddress,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        "birthdate": birthdate == null
            ? null
            : "${birthdate?.year.toString().padLeft(4, '0')}-${birthdate?.month.toString().padLeft(2, '0')}-${birthdate?.day.toString().padLeft(2, '0')}",
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "allow_email": allowEmail,
        "allow_phone": allowPhone,
        "is_deleted": isDeleted,
        "deletion_reason": deletionReason,
        "card_user_key": cardUserKey,
        "admin_role": adminRole,
        "user_permissions": List<dynamic>.from(userPermissions!.map((x) => x)),
        "groups": List<dynamic>.from(groups!.map((x) => x)),
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

  factory StoreMeal.fromJson(Map<String, dynamic> json) => StoreMeal(
        id: json["id"],
        name: json["name"],
        description: json["description"],
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
        "description": description,
        "price": price,
        "photo": photo,
        "favorite": favorite,
        "store": store,
        "category": category,
        "tag": List<dynamic>.from(tag!.map((x) => x)),
      };
}
