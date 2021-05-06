import 'package:dongu_mobile/data/model/user.dart';

class Favourite {
  User? user;

  Favourite({this.user});

  Favourite.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['store'] = this.user!.toJson();
    }
    return data;
  }
}
