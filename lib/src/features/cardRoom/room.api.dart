import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:switchfrontend/src/features/listRoom/models/room.model.dart';
import 'package:switchfrontend/src/features/login/auth.bloc.dart';
import 'package:http/http.dart' as http;

class RoomApi {
  static Future<Map<String, dynamic>> getRoom(String id) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/rooms/$id');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${AuthBloc.userToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
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

  static deleteRoom(String id) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/rooms/$id');
      await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${AuthBloc.userToken}',
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  static updateRoom(String id, String name, String description) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/rooms/$id');
      await http.patch(url, headers: {
        'Authorization': 'Bearer ${AuthBloc.userToken}',
      }, body: {
        "name": name,
        "description": description,
      });
    } catch (e) {
      rethrow;
    }
  }
}
