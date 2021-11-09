// To parse this JSON data, do
//
//     final orderReceived = orderReceivedFromJson(jsonString);

import 'dart:convert';

class OrderReceived {
  OrderReceived({
    this.id,
    this.boxes,
    this.buyingTime,
    this.status,
    this.deliveryType,
    this.cost,
    this.refCode,
    this.boxesDefinedTime,
    this.isVoted,
    this.user,
    this.address,
  });

  int? id;
  List<Box>? boxes;
  DateTime? buyingTime;
  String? status;
  String? deliveryType;
  int? cost;
  int? refCode;
  DateTime? boxesDefinedTime;
  bool? isVoted;
  User? user;
  Address? address;

  factory OrderReceived.fromRawJson(String str) =>
      OrderReceived.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderReceived.fromJson(Map<String, dynamic> json) => OrderReceived(
        id: json["id"],
        boxes: List<Box>.from(json["boxes"].map((x) => Box.fromJson(x))),
        buyingTime: DateTime.parse(json["buying_time"]),
        status: json["status"],
        deliveryType: json["delivery_type"],
        cost: json["cost"],
        refCode: json["ref_code"],
        boxesDefinedTime: json["boxes_defined_time"] == null
            ? null
            : DateTime.parse(json["boxes_defined_time"]),
        isVoted: json["is_voted"],
        user: User.fromJson(json["user"]),
        address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "boxes": List<dynamic>.from(boxes!.map((x) => x.toJson())),
        "buying_time": buyingTime!.toIso8601String(),
        "status": status,
        "delivery_type": deliveryType,
        "cost": cost,
        "ref_code": refCode,
        "boxes_defined_time": boxesDefinedTime == null
            ? null
            : boxesDefinedTime!.toIso8601String(),
        "is_voted": isVoted,
        "user": user!.toJson(),
        "address": address!.toJson(),
      };
}

class Address {
  Address({
    this.id,
    this.name,
    this.type,
    this.address,
    this.description,
    this.country,
    this.city,
    this.province,
    this.phoneNumber,
    this.tcknVkn,
    this.latitude,
    this.longitude,
    this.user,
  });

  int? id;
  String? name;
  int? type;
  String? address;
  String? description;
  String? country;
  String? city;
  String? province;
  String? phoneNumber;
  String? tcknVkn;
  double? latitude;
  double? longitude;
  int? user;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        address: json["address"],
        description: json["description"],
        country: json["country"],
        city: json["city"],
        province: json["province"],
        phoneNumber: json["phone_number"],
        tcknVkn: json["tckn_vkn"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "address": address,
        "description": description,
        "country": country,
        "city": city,
        "province": province,
        "phone_number": phoneNumber,
        "tckn_vkn": tcknVkn,
        "latitude": latitude,
        "longitude": longitude,
        "user": user,
      };
}

class Box {
  Box({
    this.id,
    this.description,
    this.defined,
    this.sold,
    this.checkTaskId,
    this.textName,
    this.name,
    this.store,
    this.saleDay,
    this.meals,
  });

  int? id;
  String? description;
  bool? defined;
  bool? sold;
  String? checkTaskId;
  String? textName;
  Name? name;
  Store? store;
  SaleDay? saleDay;
  List<dynamic>? meals;

  factory Box.fromRawJson(String str) => Box.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Box.fromJson(Map<String, dynamic> json) => Box(
        id: json["id"],
        description: json["description"],
        defined: json["defined"],
        sold: json["sold"],
        checkTaskId: json["check_task_id"],
        textName: json["text_name"],
        name: Name.fromJson(json["name"]),
        store: Store.fromJson(json["store"]),
        saleDay: SaleDay.fromJson(json["sale_day"]),
        meals: List<dynamic>.from(json["meals"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "defined": defined,
        "sold": sold,
        "check_task_id": checkTaskId,
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
  dynamic? timeLabel;

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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
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
  List<int>? favoritedBy;

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
        avgReview: json["avg_review"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        storeOwner: json["store_owner"],
        favoritedBy: List<int>.from(json["favorited_by"].map((x) => x)),
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
    this.adminRole,
    this.userPermissions,
    this.groups,
  });

  int? id;
  String? password;
  DateTime? lastLogin;
  bool? isSuperuser;
  String? email;
  dynamic? facebookEmail;
  dynamic? googleEmail;
  String? firstName;
  String? lastName;
  bool? isActive;
  bool? isStaff;
  int? activeAddress;
  DateTime? createdAt;
  String? status;
  dynamic? birthdate;
  String? phoneNumber;
  bool? allowEmail;
  bool? allowPhone;
  bool? isDeleted;
  String? deletionReason;
  dynamic? adminRole;
  List<dynamic>? userPermissions;
  List<int>? groups;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        email: json["email"],
        facebookEmail: json["facebook_email"],
        googleEmail: json["google_email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isActive: json["is_active"],
        isStaff: json["is_staff"],
        activeAddress: json["active_address"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        birthdate: json["birthdate"],
        phoneNumber: json["phone_number"],
        allowEmail: json["allow_email"],
        allowPhone: json["allow_phone"],
        isDeleted: json["is_deleted"],
        deletionReason: json["deletion_reason"],
        adminRole: json["admin_role"],
        userPermissions:
            List<dynamic>.from(json["user_permissions"].map((x) => x)),
        groups: List<int>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin!.toIso8601String(),
        "is_superuser": isSuperuser,
        "email": email,
        "facebook_email": facebookEmail,
        "google_email": googleEmail,
        "first_name": firstName,
        "last_name": lastName,
        "is_active": isActive,
        "is_staff": isStaff,
        "active_address": activeAddress,
        "created_at": createdAt!.toIso8601String(),
        "status": status,
        "birthdate": birthdate,
        "phone_number": phoneNumber,
        "allow_email": allowEmail,
        "allow_phone": allowPhone,
        "is_deleted": isDeleted,
        "deletion_reason": deletionReason,
        "admin_role": adminRole,
        "user_permissions": List<dynamic>.from(userPermissions!.map((x) => x)),
        "groups": List<dynamic>.from(groups!.map((x) => x)),
      };
}
