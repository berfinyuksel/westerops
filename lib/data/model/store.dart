

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

  String? photo;

  String? background;

  String? description;

  String? joinedTime;

  String? address;

  String? postCode;

  String? city;

  String? phoneNumber;

  String? phoneNumber2;

  String? email;

  String? websiteLink;

  String? status;

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

    this.photo,

    this.background,
   
    this.description,

    this.joinedTime,
  
    this.address,

    this.postCode,
   
    this.city,

    this.phoneNumber,

    this.phoneNumber2,
  
    this.email,
 
    this.websiteLink,
 
    this.status,
  
    this.cancelCount,
    this.createdAt,
    this.latitude,
    this.longitude,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  toJson() => _$StoreToJson(this);
}
