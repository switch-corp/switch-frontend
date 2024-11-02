import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:switchfrontend/src/features/home/models/home_data.model.dart';
import 'package:switchfrontend/src/features/home/models/schedule.model.dart';
import 'package:switchfrontend/src/features/home/models/user.model.dart';
import 'package:switchfrontend/src/features/login/auth.bloc.dart';

class HomeApi {
  static Future<HomeDataModel> getData() async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/usergroups');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${AuthBloc.userToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        print(jsonResponse);

        Map<String, dynamic> user = jsonResponse["users"][0];
        List schedules = jsonResponse["schedules"];

        return new HomeDataModel(
            user: UserModel.fromMap(user),
            schedules: schedules
                .map(
                  (e) => ScheduleModel.fromMap(e),
                )
                .toList());
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
