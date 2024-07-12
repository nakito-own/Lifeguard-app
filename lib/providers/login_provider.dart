import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider {
  final String apiUrl = 'http://95.163.221.72:8000/login';

  Future<bool> login(String email, String password) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
    };


    String jsonBody = json.encode(data);
    print('JSON Body: $jsonBody'); // Отладочный вывод JSON тела запроса

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String token = response.body; // Ответ в виде строки, а не JSON

        // Сохраняем токен в SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', token);

        return true;
      } else {
        print('Failed to login: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }
}
