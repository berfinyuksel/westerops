// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    id: json['id'] as int?,
    boxes: (json['boxes'] as List<dynamic>?)
        ?.map((e) => Box.fromJson(e as Map<String, dynamic>))
        .toList(),
    favourites: (json['favourites'] as List<dynamic>?)
        ?.map((e) => Favourite.fromJson(e as Map<String, dynamic>))
        .toList(),
    calendar: (json['calendar'] as List<dynamic>?)
        ?.map((e) => Calendar.fromJson(e as Map<String, dynamic>))
        .toList(),
    storeOwner: json['storeOwner'] as String?,
    name: json['name'] as String?,
    photo: json['photo'] as String?,
    background: json['background'] as String?,
    description: json['description'] as String?,
    joinedTime: json['joinedTime'] as String?,
    address: json['address'] as String?,
    postCode: json['postCode'] as String?,
    city: json['city'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    phoneNumber2: json['phoneNumber2'] as String?,
    email: json['email'] as String?,
    websiteLink: json['websiteLink'] as String?,
    status: json['status'] as String?,
    cancelCount: json['cancelCount'] as int?,
    createdAt: json['createdAt'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'boxes': instance.boxes,
      'favourites': instance.favourites,
      'calendar': instance.calendar,
      'storeOwner': instance.storeOwner,
      'name': instance.name,
      'photo': instance.photo,
      'background': instance.background,
      'description': instance.description,
      'joinedTime': instance.joinedTime,
      'address': instance.address,
      'postCode': instance.postCode,
      'city': instance.city,
      'phoneNumber': instance.phoneNumber,
      'phoneNumber2': instance.phoneNumber2,
      'email': instance.email,
      'websiteLink': instance.websiteLink,
      'status': instance.status,
      'cancelCount': instance.cancelCount,
      'createdAt': instance.createdAt,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
