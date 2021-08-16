// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Calendar _$CalendarFromJson(Map<String, dynamic> json) {
  return Calendar(
    id: json['id'] as int?,
    startDate: json['startDate'] as String?,
    endDate: json['endDate'] as String?,
    boxCount: json['boxCount'] as int?,
    detail: json['detail'] as String?,
    isActive: json['isActive'] as bool?,
    store: json['store'] as int?,
    timeLabel: json['timeLabel'] as int?,
  );
}

Map<String, dynamic> _$CalendarToJson(Calendar instance) => <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'boxCount': instance.boxCount,
      'detail': instance.detail,
      'isActive': instance.isActive,
      'store': instance.store,
      'timeLabel': instance.timeLabel,
    };
