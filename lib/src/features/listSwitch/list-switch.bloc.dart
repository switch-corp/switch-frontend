import 'package:switchfrontend/src/features/listSwitch/models/switch.model.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/list-switch.api.dart';

class ListSwitchBloc {
  static Future<List<SwitchModel>> getSwitch() async {
    var response = await ListSwitchApi.getSwitches();

    print(response);

    return response.map((map) => SwitchModel.fromMap(map)).toList();
  }
}
