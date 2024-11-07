import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:switchfrontend/src/features/login/auth.bloc.dart';

class ControlSwitchApi {
  static Future<Map<String, dynamic>> powerSwitch(
      String arduinoId, bool state) async {
    try {
      Uri url = Uri.parse(
          '${dotenv.env['BASE_URL']!}/api/v1/switch/power/$arduinoId');
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer ${AuthBloc.userToken}',
      }, body: {
        'state': state
      });

      print(response);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse);

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


// var url = Uri.https(
//         'switch-backend-2trd.onrender.com', '/api/v1/switch/power/123456789');

//     var response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({"state": _switchOn}),
//     );

//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');