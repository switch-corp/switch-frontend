class ScheduleModel {
  String id;
  String eventName;
  String eventDate;
  bool isActive;
  List<dynamic> switches;

  ScheduleModel(
      {required this.id,
      required this.eventName,
      required this.eventDate,
      required this.isActive,
      required this.switches});

  static ScheduleModel fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
        id: map["_id"],
        eventName: map["event_name"],
        eventDate: map["event_date"],
        isActive: map["is_active"],
        switches: map["switches"]);
  }
}
