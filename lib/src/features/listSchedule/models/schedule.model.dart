import 'package:flutter/material.dart';

class ScheduleModel {
  String id;
  String eventName;
  EventDate eventDate;
  bool isActive;
  List<dynamic> switches;

  ScheduleModel(
      {required this.id,
      required this.eventName,
      required this.eventDate,
      required this.isActive,
      required this.switches});

  static ScheduleModel fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
        id: map["_id"],
        eventName: map["event_name"],
        eventDate: cronToDescriptiveSentence(map["event_date"]),
        isActive: map["is_active"],
        switches: map["switches"]);
  }
}

class EventDate {
  String eventDate;
  String dayOfWeek;

  EventDate({required this.eventDate, required this.dayOfWeek});
}

EventDate cronToDescriptiveSentence(String cron) {
  List<String> parts = cron.split(' ');
  if (parts.length < 5) {
    throw const FormatException('A string cron deve ter pelo menos 5 campos');
  }

  String minute = parts[0];
  String hour = parts[1];
  String daysOfWeekString = parts[2];

  List<String> listDaysWeek = daysOfWeekString.split(',');

  List<String> formatedDaysWeek =
      listDaysWeek.map((day) => _mapDayOfWeek(day)).toList();

  return EventDate(
      eventDate: '${hour}h$minute', dayOfWeek: formatedDaysWeek.join(' | '));
}

String _mapDayOfWeek(String day) {
  const days = {
    '0': 'domingo',
    '1': 'segunda-feira',
    '2': 'terça-feira',
    '3': 'quarta-feira',
    '4': 'quinta-feira',
    '5': 'sexta-feira',
    '6': 'sábado',
    '7': 'domingo'
  };
  return days[day] ?? 'dia inválido';
}
