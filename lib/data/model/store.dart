import 'box.dart';
import 'calendar.dart';
import 'favourite.dart';
import 'user.dart';

class Store {
  int? id;
  List<Box>? boxes;
  List<Calendar>? calendar;
  List<Favourite>? favourites;
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
  bool? isActive;
  int? minOrderPrice;
  int? cancelCount;
  User? storeOwner;
  double? latitude;
  double? longitude;

  Store(
      {this.id,
      this.boxes,
      this.favourites,
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
      this.isActive,
      this.minOrderPrice,
      this.cancelCount,
      this.storeOwner,
      this.calendar,
      this.latitude,
      this.longitude});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    if (json['boxes'] != null) {
      boxes = [];
      json['boxes'].forEach((v) {
        boxes!.add(new Box.fromJson(v));
      });
    }
    if (json['calendar'] != null) {
      calendar = [];
      json['calendar'].forEach((v) {
        calendar!.add(new Calendar.fromJson(v));
      });
    }
    if (json['favourites'] != null) {
      favourites = [];
      json['favourites'].forEach((v) {
        favourites!.add(new Favourite.fromJson(v));
      });
    }
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    photo = json['photo'];
    background = json['background'];
    description = json['description'];
    joinedTime = json['joined_time'];
    address = json['address'];
    postCode = json['post_code'];
    city = json['city'];
    phoneNumber = json['phone_number'];
    phoneNumber2 = json['phone_number_2'];
    email = json['email'];
    websiteLink = json['website_link'];
    isActive = json['is_active'];
    minOrderPrice = json['min_order_price'];
    cancelCount = json['cancel_count'];
    storeOwner = json['store_owner'] != null ? new User.fromJson(json['store_owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    if (this.boxes != null) {
      data['boxes'] = this.boxes!.map((v) => v.toJson()).toList();
    }
    if (this.calendar != null) {
      data['calendar'] = this.calendar!.map((v) => v.toJson()).toList();
    }
    if (this.favourites != null) {
      data['favourites'] = this.favourites!.map((v) => v.toJson()).toList();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['background'] = this.background;
    data['description'] = this.description;
    data['joined_time'] = this.joinedTime;
    data['address'] = this.address;
    data['post_code'] = this.postCode;
    data['city'] = this.city;
    data['phone_number'] = this.phoneNumber;
    data['phone_number_2'] = this.phoneNumber2;
    data['email'] = this.email;
    data['website_link'] = this.websiteLink;
    data['is_active'] = this.isActive;
    data['min_order_price'] = this.minOrderPrice;
    data['cancel_count'] = this.cancelCount;
    if (this.storeOwner != null) {
      data['store_owner'] = this.storeOwner!.toJson();
    }

    return data;
  }
}
