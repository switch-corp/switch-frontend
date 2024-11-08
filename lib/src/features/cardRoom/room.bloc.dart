import 'package:switchfrontend/src/features/cardRoom/room.api.dart';
import 'package:switchfrontend/src/features/listRoom/models/room.model.dart';

class RoomBloc {
  static getRoom(String id) async {
    Map<String, dynamic> response = await RoomApi.getRoom(id);

    return Room.fromMap(response);
  }

  static deleteRoom(String id) async {
    await RoomApi.deleteRoom(id);
  }

  static updateRoom(String id, String name, String description) async {
    await RoomApi.updateRoom(id, name, description);
  }
}
