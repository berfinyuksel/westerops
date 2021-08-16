import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'box.dart';
import 'calendar.dart';
import 'favourite.dart';

part 'store.g.dart';

@JsonSerializable()
class Store {
  int? id;
  List<Box>? boxes;
  List<Favourite>? favourites;
  List<Calendar>? calendar;

  String? storeOwner;
  String? name;
  String? nameEn;
  String? nameTr;
  String? photo;
  String? photoEn;
  String? photoTr;
  String? background;
  String? backgroundEn;
  String? backgroundTr;
  String? description;
  String? descriptionEn;
  String? descriptionTr;
  String? joinedTime;
  String? joinedTimeEn;
  String? joinedTimeTr;
  String? address;
  String? addressEn;
  String? addressTr;
  String? postCode;
  String? postCodeEn;
  String? postCodeTr;
  String? city;
  String? cityEn;
  String? cityTr;
  String? phoneNumber;
  String? phoneNumberEn;
  String? phoneNumberTr;
  String? phoneNumber2;
  String? phoneNumber2En;
  String? phoneNumber2Tr;
  String? email;
  String? emailEn;
  String? emailTr;
  String? websiteLink;
  String? websiteLinkEn;
  String? websiteLinkTr;
  String? status;
  String? statusEn;
  String? statusTr;
  int? cancelCount;
  String? createdAt;
  double? latitude;
  double? longitude;
  Store({
    this.id,
    this.boxes,
    this.favourites,
    this.calendar,
    this.storeOwner,
    this.name,
    this.nameEn,
    this.nameTr,
    this.photo,
    this.photoEn,
    this.photoTr,
    this.background,
    this.backgroundEn,
    this.backgroundTr,
    this.description,
    this.descriptionEn,
    this.descriptionTr,
    this.joinedTime,
    this.joinedTimeEn,
    this.joinedTimeTr,
    this.address,
    this.addressEn,
    this.addressTr,
    this.postCode,
    this.postCodeEn,
    this.postCodeTr,
    this.city,
    this.cityEn,
    this.cityTr,
    this.phoneNumber,
    this.phoneNumberEn,
    this.phoneNumberTr,
    this.phoneNumber2,
    this.phoneNumber2En,
    this.phoneNumber2Tr,
    this.email,
    this.emailEn,
    this.emailTr,
    this.websiteLink,
    this.websiteLinkEn,
    this.websiteLinkTr,
    this.status,
    this.statusEn,
    this.statusTr,
    this.cancelCount,
    this.createdAt,
    this.latitude,
    this.longitude,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  toJson() => _$StoreToJson(this);
}
