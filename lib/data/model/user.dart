import 'favourite.dart';

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? birth;
  String? phone;
  List<Favourite>? favourites;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.favourites,
    this.birth,
    this.phone,
  });

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    birth = json['birthdate'];
    phone = json['phone_number'] ?? "+90";
    email = json['email'];
    if (json['favourites'] != null) {
      favourites = [];
      json['favourites'].forEach((v) {
        favourites!.add(new Favourite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phone;
    data['birthdate'] = this.birth;
    data['email'] = this.email;
    if (this.favourites != null) {
      data['favourites'] = this.favourites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
