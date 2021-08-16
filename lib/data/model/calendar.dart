import 'package:json_annotation/json_annotation.dart';

part 'calendar.g.dart';

@JsonSerializable()
class Calendar {
  int? id;
  String? startDate;
  String? endDate;
  int? boxCount;
  String? detail;
  bool? isActive;
  int? store;
  int? timeLabel;

  Calendar(
      {this.id,
      this.startDate,
      this.endDate,
      this.boxCount,
      this.detail,
      this.isActive,
      this.store,
      this.timeLabel});

  factory Calendar.fromJson(Map<String, dynamic> json) =>
      _$CalendarFromJson(json);
  toJson() => _$CalendarToJson(this);
}
