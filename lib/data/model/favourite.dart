import 'user.dart';

class Favourite {
  User? user;
  int? id;

  Favourite({this.user, this.id});

  Favourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['store'] = this.user!.toJson();
    }
    return data;
  }
}
