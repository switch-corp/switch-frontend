class UserModel {
  String name;
  String id;

  UserModel({required this.id, required this.name});

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(id: map["_id"], name: map["name"]);
  }
}
