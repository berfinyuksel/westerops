// To parse this JSON data, do
//
//     final AddressValues = AddressValuesFromJson(jsonString);

import 'dart:convert';

class AddressValues {
  AddressValues({
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

  factory AddressValues.fromRawJson(String str) =>
      AddressValues.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressValues.fromJson(Map<String, dynamic> json) => AddressValues(
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
