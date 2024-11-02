class ScheduleModel {
  String id;
  String action;
  String time;

  ScheduleModel({required this.id, required this.action, required this.time});

  static ScheduleModel fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
        action: map["event_name"], time: map["event_date"], id: map["_id"]);
  }
}
