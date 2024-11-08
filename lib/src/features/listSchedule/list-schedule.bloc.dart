import 'package:switchfrontend/src/features/listSchedule/models/schedule.model.dart';
import 'package:switchfrontend/src/features/listSchedule/presentation/list-schedule.api.dart';

class ListScheduleBloc {
  static Future<List<ScheduleModel>> getSchedules() async {
    var response = await ListScheduleApi.getSchedules();

    return response.map((map) => ScheduleModel.fromMap(map)).toList();
  }
}
