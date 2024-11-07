import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:switchfrontend/src/features/login/auth.bloc.dart';

class AddRoomApi {
  static createRoom(String name, String description) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/rooms');
      final response = await http.post(
        url,
        body: jsonEncode({
          "name": name,
          "description": description,
          "switches": [],
        }),
        headers: {
          'Authorization': 'Bearer ${AuthBloc.userToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);

        print(jsonResponse);

        return jsonResponse;
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
