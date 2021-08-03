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
  Null? avgReview;
  double? latitude;
  double? longitude;

  Store(
      {this.id,
      this.calendar,
      this.review,
      this.storeOwner,
      this.favoritedBy,
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
    nameEn = json['name_en'];
    nameTr = json['name_tr'];
    photo = json['photo'];
    photoEn = json['photo_en'];
    photoTr = json['photo_tr'];
    background = json['background'];
    backgroundEn = json['background_en'];
    backgroundTr = json['background_tr'];
    description = json['description'];
    descriptionEn = json['description_en'];
    descriptionTr = json['description_tr'];
    joinedTime = json['joined_time'];
    joinedTimeEn = json['joined_time_en'];
    joinedTimeTr = json['joined_time_tr'];
    address = json['address'];
    addressEn = json['address_en'];
    addressTr = json['address_tr'];
    postCode = json['post_code'];
    postCodeEn = json['post_code_en'];
    postCodeTr = json['post_code_tr'];
    city = json['city'];
    cityEn = json['city_en'];
    cityTr = json['city_tr'];
    phoneNumber = json['phone_number'];
    phoneNumberEn = json['phone_number_en'];
    phoneNumberTr = json['phone_number_tr'];
    phoneNumber2 = json['phone_number_2'];
    phoneNumber2En = json['phone_number_2_en'];
    phoneNumber2Tr = json['phone_number_2_tr'];
    email = json['email'];
    emailEn = json['email_en'];
    emailTr = json['email_tr'];
    websiteLink = json['website_link'];
    websiteLinkEn = json['website_link_en'];
    websiteLinkTr = json['website_link_tr'];
    status = json['status'];
    statusEn = json['status_en'];
    statusTr = json['status_tr'];
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
    data['name_en'] = this.nameEn;
    data['name_tr'] = this.nameTr;
    data['photo'] = this.photo;
    data['photo_en'] = this.photoEn;
    data['photo_tr'] = this.photoTr;
    data['background'] = this.background;
    data['background_en'] = this.backgroundEn;
    data['background_tr'] = this.backgroundTr;
    data['description'] = this.description;
    data['description_en'] = this.descriptionEn;
    data['description_tr'] = this.descriptionTr;
    data['joined_time'] = this.joinedTime;
    data['joined_time_en'] = this.joinedTimeEn;
    data['joined_time_tr'] = this.joinedTimeTr;
    data['address'] = this.address;
    data['address_en'] = this.addressEn;
    data['address_tr'] = this.addressTr;
    data['post_code'] = this.postCode;
    data['post_code_en'] = this.postCodeEn;
    data['post_code_tr'] = this.postCodeTr;
    data['city'] = this.city;
    data['city_en'] = this.cityEn;
    data['city_tr'] = this.cityTr;
    data['phone_number'] = this.phoneNumber;
    data['phone_number_en'] = this.phoneNumberEn;
    data['phone_number_tr'] = this.phoneNumberTr;
    data['phone_number_2'] = this.phoneNumber2;
    data['phone_number_2_en'] = this.phoneNumber2En;
    data['phone_number_2_tr'] = this.phoneNumber2Tr;
    data['email'] = this.email;
    data['email_en'] = this.emailEn;
    data['email_tr'] = this.emailTr;
    data['website_link'] = this.websiteLink;
    data['website_link_en'] = this.websiteLinkEn;
    data['website_link_tr'] = this.websiteLinkTr;
    data['status'] = this.status;
    data['status_en'] = this.statusEn;
    data['status_tr'] = this.statusTr;
    data['cancel_count'] = this.cancelCount;
    data['created_at'] = this.createdAt;
    data['avg_review'] = this.avgReview;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
