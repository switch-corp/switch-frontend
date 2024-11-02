import 'package:switchfrontend/src/features/home/home.api.dart';

class HomeBloc {
  static getData() async {
    return await HomeApi.getData();
  }
}
