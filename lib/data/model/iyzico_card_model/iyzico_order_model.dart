// To parse this JSON data, do
//
//     final iyzcoRegisteredCard = iyzcoRegisteredCardFromJson(jsonString);

import 'dart:convert';

class IyzcoOrderCreate {
  IyzcoOrderCreate({
    this.id,
    this.boxes,
    this.courierTime,
    this.review,
    this.buyingTime,
    this.status,
    this.deliveryType,
    this.cost,
    this.refCode,
    this.boxesDefinedTime,
    this.isVoted,
    this.description,
    this.paymentStatus,
    this.paymentId,
    this.paymentTransactionId,
    this.user,
    this.address,
    this.billingAddress,
  });

  final int? id;
  final List<Box>? boxes;
  final dynamic courierTime;
  final List<dynamic>? review;
  final DateTime? buyingTime;
  final String? status;
  final String? deliveryType;
  final int? cost;
  final int? refCode;
  final dynamic boxesDefinedTime;
  final bool? isVoted;
  final dynamic description;
  final String? paymentStatus;
  final String? paymentId;
  final String? paymentTransactionId;
  final User? user;
  final Address? address;
  final Address? billingAddress;

  factory IyzcoOrderCreate.fromRawJson(String str) =>
      IyzcoOrderCreate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IyzcoOrderCreate.fromJson(Map<String, dynamic> json) =>
      IyzcoOrderCreate(
        id: json["id"] == null ? null : json["id"],
        boxes: json["boxes"] == null
            ? null
            : List<Box>.from(json["boxes"].map((x) => Box.fromJson(x))),
        courierTime: json["courier_time"],
        review: json["review"] == null
            ? null
            : List<dynamic>.from(json["review"].map((x) => x)),
        buyingTime: json["buying_time"] == null
            ? null
            : DateTime.parse(json["buying_time"]),
        status: json["status"] == null ? null : json["status"],
        deliveryType:
            json["delivery_type"] == null ? null : json["delivery_type"],
        cost: json["cost"] == null ? null : json["cost"],
        refCode: json["ref_code"] == null ? null : json["ref_code"],
        boxesDefinedTime: json["boxes_defined_time"],
        isVoted: json["is_voted"] == null ? null : json["is_voted"],
        description: json["description"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        paymentId: json["paymentId"] == null ? null : json["paymentId"],
        paymentTransactionId: json["payment_transaction_id"] == null
            ? null
            : json["payment_transaction_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        billingAddress: json["billing_address"] == null
            ? null
            : Address.fromJson(json["billing_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "boxes": boxes == null
            ? null
            : List<dynamic>.from(boxes!.map((x) => x.toJson())),
        "courier_time": courierTime,
        "review":
            review == null ? null : List<dynamic>.from(review!.map((x) => x)),
        "buying_time":
            buyingTime == null ? null : buyingTime?.toIso8601String(),
        "status": status == null ? null : status,
        "delivery_type": deliveryType == null ? null : deliveryType,
        "cost": cost == null ? null : cost,
        "ref_code": refCode == null ? null : refCode,
        "boxes_defined_time": boxesDefinedTime,
        "is_voted": isVoted == null ? null : isVoted,
        "description": description,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "paymentId": paymentId == null ? null : paymentId,
        "payment_transaction_id":
            paymentTransactionId == null ? null : paymentTransactionId,
        "user": user == null ? null : user?.toJson(),
        "address": address == null ? null : address?.toJson(),
        "billing_address":
            billingAddress == null ? null : billingAddress?.toJson(),
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

  final int? id;
  final String? name;
  final int? type;
  final String? address;
  final String? description;
  final String? country;
  final String? city;
  final String? province;
  final String? phoneNumber;
  final String? tcknVkn;
  final double? latitude;
  final double? longitude;
  final int? user;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        address: json["address"] == null ? null : json["address"],
        description: json["description"] == null ? null : json["description"],
        country: json["country"] == null ? null : json["country"],
        city: json["city"] == null ? null : json["city"],
        province: json["province"] == null ? null : json["province"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        tcknVkn: json["tckn_vkn"] == null ? null : json["tckn_vkn"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        user: json["user"] == null ? null : json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "address": address == null ? null : address,
        "description": description == null ? null : description,
        "country": country == null ? null : country,
        "city": city == null ? null : city,
        "province": province == null ? null : province,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "tckn_vkn": tcknVkn == null ? null : tcknVkn,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "user": user == null ? null : user,
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

  final int? id;
  final dynamic? description;
  final bool? defined;
  final bool? sold;
  final String? checkTaskId;
  final String? textName;
  final Name? name;
  final Store? store;
  final SaleDay? saleDay;
  final List<dynamic>? meals;

  factory Box.fromRawJson(String str) => Box.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Box.fromJson(Map<String, dynamic> json) => Box(
        id: json["id"] == null ? null : json["id"],
        description: json["description"],
        defined: json["defined"] == null ? null : json["defined"],
        sold: json["sold"] == null ? null : json["sold"],
        checkTaskId:
            json["check_task_id"] == null ? null : json["check_task_id"],
        textName: json["text_name"] == null ? null : json["text_name"],
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        saleDay: json["sale_day"] == null
            ? null
            : SaleDay.fromJson(json["sale_day"]),
        meals: json["meals"] == null
            ? null
            : List<dynamic>.from(json["meals"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "description": description,
        "defined": defined == null ? null : defined,
        "sold": sold == null ? null : sold,
        "check_task_id": checkTaskId == null ? null : checkTaskId,
        "text_name": textName == null ? null : textName,
        "name": name == null ? null : name?.toJson(),
        "store": store == null ? null : store?.toJson(),
        "sale_day": saleDay == null ? null : saleDay?.toJson(),
        "meals":
            meals == null ? null : List<dynamic>.from(meals!.map((x) => x)),
      };
}

class Name {
  Name({
    this.id,
    this.name,
    this.confirmed,
    this.store,
  });

  final int? id;
  final String? name;
  final bool? confirmed;
  final int? store;

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        store: json["store"] == null ? null : json["store"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "confirmed": confirmed == null ? null : confirmed,
        "store": store == null ? null : store,
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

  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? boxCount;
  final dynamic detail;
  final bool? isActive;
  final dynamic boxCreateTaskId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? store;
  final dynamic timeLabel;

  factory SaleDay.fromRawJson(String str) => SaleDay.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleDay.fromJson(Map<String, dynamic> json) => SaleDay(
        id: json["id"] == null ? null : json["id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        boxCount: json["box_count"] == null ? null : json["box_count"],
        detail: json["detail"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        boxCreateTaskId: json["box_create_task_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        store: json["store"] == null ? null : json["store"],
        timeLabel: json["time_label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "start_date": startDate == null ? null : startDate?.toIso8601String(),
        "end_date": endDate == null ? null : endDate?.toIso8601String(),
        "box_count": boxCount == null ? null : boxCount,
        "detail": detail,
        "is_active": isActive == null ? null : isActive,
        "box_create_task_id": boxCreateTaskId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "store": store == null ? null : store,
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

  final int? id;
  final String? name;
  final String? photo;
  final String? background;
  final String? description;
  final DateTime? joinedTime;
  final String? address;
  final String? postCode;
  final String? city;
  final String? province;
  final String? phoneNumber;
  final String? phoneNumber2;
  final String? email;
  final String? websiteLink;
  final String? status;
  final int? cancelCount;
  final DateTime? createdAt;
  final double? avgReview;
  final double? latitude;
  final double? longitude;
  final int? storeOwner;
  final List<int>? favoritedBy;

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"] == null ? null : json["id"],
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
        status: json["status"] == null ? null : json["status"],
        cancelCount: json["cancel_count"] == null ? null : json["cancel_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        avgReview:
            json["avg_review"] == null ? null : json["avg_review"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        storeOwner: json["store_owner"] == null ? null : json["store_owner"],
        favoritedBy: json["favorited_by"] == null
            ? null
            : List<int>.from(json["favorited_by"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
        "background": background == null ? null : background,
        "description": description == null ? null : description,
        "joined_time":
            joinedTime == null ? null : joinedTime?.toIso8601String(),
        "address": address == null ? null : address,
        "post_code": postCode == null ? null : postCode,
        "city": city == null ? null : city,
        "province": province == null ? null : province,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "phone_number_2": phoneNumber2 == null ? null : phoneNumber2,
        "email": email == null ? null : email,
        "website_link": websiteLink == null ? null : websiteLink,
        "status": status == null ? null : status,
        "cancel_count": cancelCount == null ? null : cancelCount,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "avg_review": avgReview == null ? null : avgReview,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "store_owner": storeOwner == null ? null : storeOwner,
        "favorited_by": favoritedBy == null
            ? null
            : List<dynamic>.from(favoritedBy!.map((x) => x)),
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

  final int? id;
  final String? password;
  final DateTime? lastLogin;
  final bool? isSuperuser;
  final String? email;
  final dynamic facebookEmail;
  final dynamic googleEmail;
  final String? firstName;
  final String? lastName;
  final bool? isActive;
  final bool? isStaff;
  final int? activeAddress;
  final DateTime? createdAt;
  final String? status;
  final dynamic birthdate;
  final String? phoneNumber;
  final bool? allowEmail;
  final bool? allowPhone;
  final bool? isDeleted;
  final String? deletionReason;
  final String? cardUserKey;
  final dynamic adminRole;
  final List<dynamic>? userPermissions;
  final List<int>? groups;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        password: json["password"] == null ? null : json["password"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"] == null ? null : json["is_superuser"],
        email: json["email"] == null ? null : json["email"],
        facebookEmail: json["facebook_email"],
        googleEmail: json["google_email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isStaff: json["is_staff"] == null ? null : json["is_staff"],
        activeAddress:
            json["active_address"] == null ? null : json["active_address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"] == null ? null : json["status"],
        birthdate: json["birthdate"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        allowEmail: json["allow_email"] == null ? null : json["allow_email"],
        allowPhone: json["allow_phone"] == null ? null : json["allow_phone"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        deletionReason:
            json["deletion_reason"] == null ? null : json["deletion_reason"],
        cardUserKey:
            json["card_user_key"] == null ? null : json["card_user_key"],
        adminRole: json["admin_role"],
        userPermissions: json["user_permissions"] == null
            ? null
            : List<dynamic>.from(json["user_permissions"].map((x) => x)),
        groups: json["groups"] == null
            ? null
            : List<int>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "password": password == null ? null : password,
        "last_login": lastLogin == null ? null : lastLogin?.toIso8601String(),
        "is_superuser": isSuperuser == null ? null : isSuperuser,
        "email": email == null ? null : email,
        "facebook_email": facebookEmail,
        "google_email": googleEmail,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "is_active": isActive == null ? null : isActive,
        "is_staff": isStaff == null ? null : isStaff,
        "active_address": activeAddress == null ? null : activeAddress,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "status": status == null ? null : status,
        "birthdate": birthdate,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "allow_email": allowEmail == null ? null : allowEmail,
        "allow_phone": allowPhone == null ? null : allowPhone,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "deletion_reason": deletionReason == null ? null : deletionReason,
        "card_user_key": cardUserKey == null ? null : cardUserKey,
        "admin_role": adminRole,
        "user_permissions": userPermissions == null
            ? null
            : List<dynamic>.from(userPermissions!.map((x) => x)),
        "groups":
            groups == null ? null : List<dynamic>.from(groups!.map((x) => x)),
      };
}
