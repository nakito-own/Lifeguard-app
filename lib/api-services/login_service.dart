import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
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
        Map<String, dynamic> responseBody = json.decode(response.body);
        String token = responseBody['JWT'];
        int userId = responseBody['userId'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', token);
        await prefs.setInt('userId', userId);

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
