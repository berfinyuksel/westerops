// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoxOrder _$BoxOrderFromJson(Map<String, dynamic> json) => BoxOrder(
      id: json['id'] as int?,
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
      text_name: json['text_name'] as String?,
      description: json['description'] as String?,
      defined: json['defined'] as bool?,
      sold: json['sold'] as bool?,
      store: json['store'] == null
          ? null
          : SearchStore.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoxOrderToJson(BoxOrder instance) => <String, dynamic>{
      'id': instance.id,
      'meals': instance.meals,
      'text_name': instance.text_name,
      'description': instance.description,
      'defined': instance.defined,
      'sold': instance.sold,
      'store': instance.store,
    };
