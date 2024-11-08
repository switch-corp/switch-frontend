import 'package:switchfrontend/src/features/linkSwitch/linkSwitch.api.dart';

class LinkSwitchBloc {
  static updateSwitches(String roomId, List<String> switches) async {
    await LinkSwitchApi.updateSwitches(roomId, switches);
  }
}
