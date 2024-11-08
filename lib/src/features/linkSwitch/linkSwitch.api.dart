import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:switchfrontend/src/features/login/auth.bloc.dart';

class LinkSwitchApi {
  static Future<void> updateSwitches(
      String roomId, List<String> swtiches) async {
    try {
      Uri url = Uri.parse(
        '${dotenv.env['BASE_URL']!}/api/v1/rooms/${roomId}/switches',
      );
      final response = await http.patch(
        url,
        body: jsonEncode({
          "switches": swtiches,
        }),
        headers: {
          'Authorization': 'Bearer ${AuthBloc.userToken}',
          'Content-Type': 'application/json',
        },
      );

      print(response);
    } catch (e) {
      print(e);
    }
  }
}
