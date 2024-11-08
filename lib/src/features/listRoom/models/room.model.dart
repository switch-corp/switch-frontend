class Room {
  String id;
  String name;
  String description;
  List<RoomSwitch> switches;

  Room({
    required this.id,
    required this.description,
    required this.name,
    this.switches = const [],
  });

  static Room fromMap(Map<String, dynamic> map) {
    var switches = map['switches'] ?? [];
    List<RoomSwitch> list = (switches as List).map((swt) {
      return RoomSwitch(id: swt['_id'], name: swt['name']);
    }).toList();

    return Room(
      id: map['_id'],
      description: map["description"],
      name: map["name"],
      switches: list,
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
