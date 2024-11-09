class ModelSchedule {
  String id;
  String action;
  String time;

  ModelSchedule({required this.id, required this.action, required this.time});

  static ModelSchedule fromMap(Map<String, dynamic> map) {
    return ModelSchedule(
        action: map["event_name"], time: map["event_date"], id: map["_id"]);
  }
}
