class SwitchModel {
  String id;
  String name;
  bool is_active;
  String arduino_id;

  SwitchModel(
      {required this.id,
      required this.name,
      required this.is_active,
      required this.arduino_id});

  static SwitchModel fromMap(Map<String, dynamic> map) {
    return SwitchModel(
        id: map['_id'],
        name: map['name'],
        is_active: map['is_active'],
        arduino_id: map['arduino_id']);
  }
}
