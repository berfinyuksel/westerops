

import 'package:dongu_mobile/data/model/box.dart';
import 'package:dongu_mobile/data/model/calendar.dart';

import 'favourite.dart';

class Store {
  int? id;
  List<Box>? boxes;
  List<Favourite>? favourites;
  List<Calendar>? calendar;
  List<Null>? review;
  String? storeOwner;
  List<Null>? favoritedBy;
  String? name;

  String? photo;

  String? background;

  String? description;

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
  double? avgReview;
  double? latitude;
  double? longitude;

  Store(
      {this.id,
      this.calendar,
      this.review,
      this.storeOwner,
      this.favoritedBy,
      this.name,
      this.photo,
      this.background,
      this.description,
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
      this.avgReview,
      this.latitude,
      this.longitude});

   Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['calendar'] != null) {
      calendar = [];
      json['calendar'].forEach((v) {
        calendar!.add(Calendar.fromJson(v));
      });
    }

    name = json['name'];

    photo = json['photo'];

    background = json['background'];

    description = json['description'];

    address = json['address'];

    postCode = json['post_code'];

    city = json['city'];

    phoneNumber = json['phone_number'];

    phoneNumber2 = json['phone_number_2'];

    email = json['email'];
    websiteLink = json['website_link'];
    status = json['status'];

    cancelCount = json['cancel_count'];
    createdAt = json['created_at'];
    avgReview = json['avg_review'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.calendar != null) {
      data['calendar'] = this.calendar!.map((v) => v.toJson()).toList();
    }

    data['name'] = this.name;

    data['photo'] = this.photo;

    data['background'] = this.background;

    data['description'] = this.description;

    data['address'] = this.address;

    data['post_code'] = this.postCode;

    data['city'] = this.city;

    data['phone_number'] = this.phoneNumber;

    data['phone_number_2'] = this.phoneNumber2;

    data['email'] = this.email;

    data['website_link'] = this.websiteLink;

    data['status'] = this.status;

    data['cancel_count'] = this.cancelCount;
    data['created_at'] = this.createdAt;
   data['avg_review'] = this.avgReview;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
