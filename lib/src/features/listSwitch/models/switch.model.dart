class SwitchModel {
  String id;
  String name;
  bool is_active;

  SwitchModel({required this.id, required this.name, required this.is_active});

  static SwitchModel fromMap(Map<String, dynamic> map) {
    return SwitchModel(
      id: map['_id'],
      name: map['name'],
      is_active: map['is_active'],
    );
  }
}
