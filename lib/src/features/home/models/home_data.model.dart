import 'package:switchfrontend/src/features/home/models/schedule.model.dart';
import 'package:switchfrontend/src/features/home/models/user.model.dart';

class HomeDataModel {
  UserModel user;
  List<ScheduleModel> schedules;

  HomeDataModel({required this.user, required this.schedules});
}
