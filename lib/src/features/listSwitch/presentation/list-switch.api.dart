import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:switchfrontend/src/features/login/auth.bloc.dart';

class ListSwitchApi {
  static Future<List> getSwitches() async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/usergroups');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${AuthBloc.userToken}',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        print(jsonResponse);

        return jsonResponse['switches'];
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> addSwitch(
      String name, String arduinoId) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/switch/create');
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer ${AuthBloc.userToken}',
      }, body: {
        'name': name,
        'arduino_id': arduinoId
      });

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        return jsonResponse;
      } else {
        throw Exception(
            'Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
