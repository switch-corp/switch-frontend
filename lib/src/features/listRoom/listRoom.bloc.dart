import 'package:switchfrontend/src/features/listRoom/listRoom.api.dart';
import 'package:switchfrontend/src/features/listRoom/models/room.model.dart';

class ListRoomBloc {
  static Future<List<Room>> getRooms() async {
    try {
      var response = await ListRoomApi.getRooms();

      return response.map((map) => Room.fromMap(map)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
