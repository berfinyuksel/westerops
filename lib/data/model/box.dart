import 'dart:convert';

import 'package:dongu_mobile/data/model/store.dart';

List<Box> boxFromJson(String str) =>
    List<Box>.from(json.decode(str).map((x) => Box.fromJson(x)));

String boxToJson(List<Box> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Box {
  Box({
    this.id,
    this.description,
    this.descriptionEn,
    this.descriptionTr,
    this.defined,
    this.definedEn,
    this.definedTr,
    this.sold,
    this.soldEn,
    this.soldTr,
    this.checkTaskId,
    this.textName,
    this.textNameEn,
    this.textNameTr,
    this.name,
    this.nameEn,
    this.nameTr,
    this.store,
    this.saleDay,
    this.meals,
  });

  int? id;
  String? description;
  String? descriptionEn;
  String? descriptionTr;
  bool? defined;
  bool? definedEn;
  bool? definedTr;
  bool? sold;
  bool? soldEn;
  bool? soldTr;
  String? checkTaskId;
  String? textName;
  String? textNameEn;
  dynamic textNameTr;
  Name? name;
  Name? nameEn;
  Name? nameTr;
  Store? store;
  SaleDay? saleDay;
  List<Meal>? meals;

  factory Box.fromJson(Map<String?, dynamic> json) => Box(
        id: json["id"],
        description: json["description"],
        descriptionEn: json["description_en"],
        descriptionTr: json["description_tr"],
        defined: json["defined"],
        definedEn: json["defined_en"],
        definedTr: json["defined_tr"],
        sold: json["sold"],
        soldEn: json["sold_en"],
        soldTr: json["sold_tr"],
        checkTaskId: json["check_task_id"],
        textName: json["text_name"],
        textNameEn: json["text_name_en"],
        textNameTr: json["text_name_tr"],
        name: Name.fromJson(json["name"]),
        nameEn: Name.fromJson(json["name_en"]),
        nameTr: Name.fromJson(json["name_tr"]),
        store: Store.fromJson(json["store"]),
        saleDay: SaleDay.fromJson(json["sale_day"]),
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "description": description,
        "description_en": descriptionEn,
        "description_tr": descriptionTr,
        "defined": defined,
        "defined_en": definedEn,
        "defined_tr": definedTr,
        "sold": sold,
        "sold_en": soldEn,
        "sold_tr": soldTr,
        "check_task_id": checkTaskId,
        "text_name": textName,
        "text_name_en": textNameEn,
        "text_name_tr": textNameTr,
        "name": name!.toJson(),
        "name_en": nameEn!.toJson(),
        "name_tr": nameTr!.toJson(),
        "store": store!.toJson(),
        "sale_day": saleDay!.toJson(),
        "meals": List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}

class Meal {
  Meal({
    this.id,
    this.name,
    this.nameEn,
    this.nameTr,
    this.description,
    this.descriptionEn,
    this.descriptionTr,
    this.price,
    this.photo,
    this.photoEn,
    this.photoTr,
    this.favorite,
    this.confirmed,
    this.store,
    this.category,
    this.tag,
  });

  int? id;
  String? name;
  String? nameEn;
  String? nameTr;
  String? description;
  String? descriptionEn;
  String? descriptionTr;
  int? price;
  String? photo;
  String? photoEn;
  String? photoTr;
  bool? favorite;
  bool? confirmed;
  int? store;
  int? category;
  List<int>? tag;

  factory Meal.fromJson(Map<String?, dynamic> json) => Meal(
        id: json["id"],
        name: json["name"],
        nameEn: json["name_en"],
        nameTr: json["name_tr"],
        description: json["description"],
        descriptionEn: json["description_en"],
        descriptionTr: json["description_tr"],
        price: json["price"],
        photo: json["photo"],
        photoEn: json["photo_en"],
        photoTr: json["photo_tr"],
        favorite: json["favorite"],
        confirmed: json["confirmed"],
        store: json["store"],
        category: json["category"],
        tag: List<int>.from(json["tag"].map((x) => x)),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_en": nameEn,
        "name_tr": nameTr,
        "description": description,
        "description_en": descriptionEn,
        "description_tr": descriptionTr,
        "price": price,
        "photo": photo,
        "photo_en": photoEn,
        "photo_tr": photoTr,
        "favorite": favorite,
        "confirmed": confirmed,
        "store": store,
        "category": category,
        "tag": List<dynamic>.from(tag!.map((x) => x)),
      };
}

class Name {
  Name({
    this.id,
    this.name,
    this.nameEn,
    this.nameTr,
    this.confirmed,
    this.store,
  });

  int? id;
  String? name;
  String? nameEn;
  String? nameTr;
  bool? confirmed;
  int? store;

  factory Name.fromJson(Map<String?, dynamic> json) => Name(
        id: json["id"],
        name: json["name"],
        nameEn: json["name_en"],
        nameTr: json["name_tr"],
        confirmed: json["confirmed"],
        store: json["store"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_en": nameEn,
        "name_tr": nameTr,
        "confirmed": confirmed,
        "store": store,
      };
}

class SaleDay {
  SaleDay({
    this.id,
    this.startDate,
    this.startDateEn,
    this.startDateTr,
    this.endDate,
    this.endDateEn,
    this.endDateTr,
    this.boxCount,
    this.detail,
    this.detailEn,
    this.detailTr,
    this.isActive,
    this.boxCreateTaskId,
    this.boxCreateTaskIdEn,
    this.boxCreateTaskIdTr,
    this.createdAt,
    this.updatedAt,
    this.store,
    this.timeLabel,
  });

  int? id;
  DateTime? startDate;
  DateTime? startDateEn;
  DateTime? startDateTr;
  DateTime? endDate;
  DateTime? endDateEn;
  DateTime? endDateTr;
  int? boxCount;
  String? detail;
  dynamic detailEn;
  dynamic detailTr;
  bool? isActive;
  String? boxCreateTaskId;
  String? boxCreateTaskIdEn;
  dynamic boxCreateTaskIdTr;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic store;
  dynamic timeLabel;

  factory SaleDay.fromJson(Map<String?, dynamic> json) => SaleDay(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        startDateEn: DateTime.parse(json["start_date_en"]),
        startDateTr: DateTime.parse(json["start_date_tr"]),
        endDate: DateTime.parse(json["end_date"]),
        endDateEn: DateTime.parse(json["end_date_en"]),
        endDateTr: DateTime.parse(json["end_date_tr"]),
        boxCount: json["box_count"],
        detail: json["detail"],
        detailEn: json["detail_en"],
        detailTr: json["detail_tr"],
        isActive: json["is_active"],
        boxCreateTaskId: json["box_create_task_id"],
        boxCreateTaskIdEn: json["box_create_task_id_en"],
        boxCreateTaskIdTr: json["box_create_task_id_tr"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        store: json["store"],
        timeLabel: json["time_label"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "start_date": startDate!.toIso8601String(),
        "start_date_en": startDateEn!.toIso8601String(),
        "start_date_tr": startDateTr!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "end_date_en": endDateEn!.toIso8601String(),
        "end_date_tr": endDateTr!.toIso8601String(),
        "box_count": boxCount,
        "detail": detail,
        "detail_en": detailEn,
        "detail_tr": detailTr,
        "is_active": isActive,
        "box_create_task_id": boxCreateTaskId,
        "box_create_task_id_en": boxCreateTaskIdEn,
        "box_create_task_id_tr": boxCreateTaskIdTr,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "store": store,
        "time_label": timeLabel,
      };
}
