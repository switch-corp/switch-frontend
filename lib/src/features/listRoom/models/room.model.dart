class Room {
  String id;
  String name;
  String description;
  List<RoomSwitch>? switches;

  Room({
    required this.id,
    required this.description,
    required this.name,
    this.switches,
  });

  static Room fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['_id'],
      description: map["description"],
      name: map["name"],
      switches: [],
    );
  }
}

class RoomSwitch {
  String id;
  String name;

  RoomSwitch({required this.id, required this.name});

  static List<RoomSwitch> fromMapList(List<Map> list) {
    return list
        .map((map) => RoomSwitch(id: map["_id"], name: map["name"]))
        .toList();
  }
}
