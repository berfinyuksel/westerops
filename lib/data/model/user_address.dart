// To parse this JSON data, do
//
//     final userAddress = userAddressFromJson(jsonString);

class UserAddress {
  UserAddress({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.type,
    this.address,
    this.description,
    this.country,
    this.city,
    this.province,
    this.phoneNumber,
    this.tcknVkn,
    this.latitude,
    this.longitude,
  });

  int? id;
  String? name;
  int? type;
  String? address;
  String? description;
  String? country;
  String? city;
  String? province;
  String? phoneNumber;
  String? tcknVkn;
  double? latitude;
  double? longitude;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        address: json["address"],
        description: json["description"],
        country: json["country"],
        city: json["city"],
        province: json["province"],
        phoneNumber: json["phone_number"],
        tcknVkn: json["tckn_vkn"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "address": address,
        "description": description,
        "country": country,
        "city": city,
        "province": province,
        "phone_number": phoneNumber,
        "tckn_vkn": tcknVkn,
        "latitude": latitude,
        "longitude": longitude,
      };
}
