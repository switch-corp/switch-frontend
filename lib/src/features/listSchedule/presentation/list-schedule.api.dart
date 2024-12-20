import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:switchfrontend/src/features/login/auth.bloc.dart';

class ListScheduleApi {
  static Future<List> getSchedules() async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/usergroups');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${AuthBloc.userToken}',
        'Conten-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        return jsonResponse['schedules'];
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createSchedule(
      String eventName, String eventDate, List<String> switches) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/schedule/create');
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer ${AuthBloc.userToken}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "event_name": eventName,
            "event_date": eventDate,
            "switches": switches
          }));

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> activateSchedule(String id, bool active) async {
    try {
      Uri url =
          Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/schedule/update/$id');
      final response = await http.put(url,
          headers: {
            'Authorization': 'Bearer ${AuthBloc.userToken}',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "is_active": !active,
          }));

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteSwitch(String id) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/schedule/$id');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${AuthBloc.userToken}',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
