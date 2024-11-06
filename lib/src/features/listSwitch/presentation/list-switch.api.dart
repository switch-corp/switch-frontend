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
}
