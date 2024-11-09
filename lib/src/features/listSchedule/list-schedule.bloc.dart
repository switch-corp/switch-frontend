import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/listSchedule/models/schedule.model.dart';
import 'package:switchfrontend/src/features/listSchedule/presentation/list-schedule.api.dart';

class ListScheduleBloc {
  static Future<List<ScheduleModel>> getSchedules() async {
    var response = await ListScheduleApi.getSchedules();

    return response.map((map) => ScheduleModel.fromMap(map)).toList();
  }

  static Future<void> createSchedule(String eventName, TimeOfDay eventDate,
      List<bool> selectedDays, List<String> switches) async {
    String dateEvent = dataToCronString(eventDate, selectedDays);

    await ListScheduleApi.createSchedule(eventName, dateEvent, switches);
  }

  static Future<void> deactivateSchedule(String id, bool active) async {
    await ListScheduleApi.activateSchedule(id, active);
  }

  static Future<void> deleteSwitch(String id) async {
    await ListScheduleApi.deleteSwitch(id);
  }
}

String dataToCronString(TimeOfDay time, List<bool> daysWeek) {
  List<int> selectedDays = [];

  for (int i = 0; i < daysWeek.length; i++) {
    daysWeek[i] == true ? selectedDays.add(i + 1) : 1 + 1;
  }

  return Schedule(hours: time.hour, minutes: time.minute, days: selectedDays)
      .toCronString();
}
