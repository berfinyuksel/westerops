// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Box _$BoxFromJson(Map<String, dynamic> json) {
  return Box(
    id: json['id'] as int?,
    meals: (json['meals'] as List<dynamic>?)
        ?.map((e) => Meal.fromJson(e as Map<String, dynamic>))
        .toList(),
    name: json['name'] as String?,
    description: json['description'] as String?,
    defined: json['defined'] as bool?,
    sold: json['sold'] as bool?,
    store: json['store'] as int?,
    saleDay: json['saleDay'] as int?,
  );
}

Map<String, dynamic> _$BoxToJson(Box instance) => <String, dynamic>{
      'id': instance.id,
      'meals': instance.meals,
      'name': instance.name,
      'description': instance.description,
      'defined': instance.defined,
      'sold': instance.sold,
      'store': instance.store,
      'saleDay': instance.saleDay,
    };
