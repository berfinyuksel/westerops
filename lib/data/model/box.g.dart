// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Box _$BoxFromJson(Map<String, dynamic> json) {
  return Box(
    id: json['id'] as int?,
    meals: (json['meals'] as List<dynamic>?)?.map((e) => e as int).toList(),
    text_name: json['text_name'] as String?,
    description: json['description'] as String?,
    defined: json['defined'] as bool?,
    sold: json['sold'] as bool?,
    store: json['store'] as int?,

  );
}

Map<String, dynamic> _$BoxToJson(Box instance) => <String, dynamic>{
      'id': instance.id,
      'meals': instance.meals,
      'text_name': instance.text_name,
      'description': instance.description,
      'defined': instance.defined,
      'sold': instance.sold,
      'store': instance.store,
      'sale_day': instance.sale_day,
    };
