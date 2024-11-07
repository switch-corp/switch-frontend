import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  static Future<String> login(String email, String password) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/auth/signin');
      final response = await http
          .post(url, body: {"email": "$email", "password": "$password"});

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String accessToken = jsonResponse['acess_token'];

        print('Access Token: $accessToken');
        return accessToken;
      } else {
        print(response.statusCode);
        throw Exception();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<String> signUp(
      String email, String password, String name) async {
    try {
      Uri url = Uri.parse('${dotenv.env['BASE_URL']!}/api/v1/auth/signup');
      final response = await http.post(url,
          body: {"email": "$email", "password": "$password", "name": "$name"});

      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        String accessToken = jsonResponse['acess_token'];

        print('Access Token: $accessToken');
        return accessToken;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
