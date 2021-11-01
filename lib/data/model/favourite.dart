class Favourite {
  int? id;
  String? name;
  String? city;
  String? province;
  String? phoneNumber;
  String? status;

  Favourite(
      {this.id,
      this.name,
      this.city,
      this.province,
      this.phoneNumber,
      this.status});

  Favourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    province = json['province'];
    phoneNumber = json['phone_number'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['province'] = this.province;
    data['phone_number'] = this.phoneNumber;
    data['status'] = this.status;
    return data;
  }
}
