class Room {
  String id;
  String name;
  String description;

  Room({
    required this.id,
    required this.description,
    required this.name,
  });

  static Room fromMap(Map<String, dynamic> map) {
    return new Room(
      id: map['_id'],
      description: map["description"],
      name: map["name"],
    );
  }
}
