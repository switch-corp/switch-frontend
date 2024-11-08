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
  String dayOfMonth = parts[2];
  String month = parts[3];
  String dayOfWeek = parts[4];

  return EventDate(
      eventDate: '$dayOfMonth/$month, ${hour}h$minute', dayOfWeek: dayOfWeek);
}

String _mapMonth(String month) {
  const months = {
    '1': 'janeiro',
    '2': 'fevereiro',
    '3': 'março',
    '4': 'abril',
    '5': 'maio',
    '6': 'junho',
    '7': 'julho',
    '8': 'agosto',
    '9': 'setembro',
    '10': 'outubro',
    '11': 'novembro',
    '12': 'dezembro'
  };
  return months[month] ?? 'mês inválido';
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

class ScheduleDto {
  String eventName;
  TimeOfDay eventDate;
  List<bool> daysWeek;
  List<String>? switches;

  ScheduleDto(
      {required this.eventName,
      required this.daysWeek,
      required this.eventDate});
}
