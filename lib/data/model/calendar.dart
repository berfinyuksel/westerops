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

  Calendar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    boxCount = json['box_count'];
    detail = json['detail'];
    isActive = json['is_active'];
    store = json['store'];
    timeLabel = json['time_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['box_count'] = this.boxCount;
    data['detail'] = this.detail;
    data['is_active'] = this.isActive;
    data['store'] = this.store;
    data['time_label'] = this.timeLabel;
    return data;
  }
}