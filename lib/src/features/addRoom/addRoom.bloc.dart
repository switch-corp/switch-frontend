import 'package:switchfrontend/src/features/addRoom/addRoom.api.dart';
import 'package:switchfrontend/src/features/addRoom/addRoom.states.dart';

class AddRoomBloc {
  static Future<AddRoomState> createRoom(
      String name, String description) async {
    try {
      await AddRoomApi.createRoom(name, description);
      return SucessAddRoomState();
    } catch (e) {
      return FailureAddRoomState();
    }
  }
}
