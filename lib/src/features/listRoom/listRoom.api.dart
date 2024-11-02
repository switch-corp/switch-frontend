import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:switchfrontend/src/features/listRoom/models/room.model.dart';
import 'package:http/http.dart' as http;
import 'package:switchfrontend/src/features/login/auth.bloc.dart';

class ListRoomApi {
  static Future<List> getRooms() async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/rooms');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${AuthBloc.userToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

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
