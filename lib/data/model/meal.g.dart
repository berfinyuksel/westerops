// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) {
  return Meal(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: json['price'] as int?,
    photo: json['photo'] as String?,
    favorite: json['favorite'] as bool?,
    confirmed: json['confirmed'] as bool?,
    store: json['store'] as int?,
    category: json['category'] as int?,
    tag: (json['tag'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'photo': instance.photo,
      'favorite': instance.favorite,
      'confirmed': instance.confirmed,
      'store': instance.store,
      'category': instance.category,
      'tag': instance.tag,
    };
