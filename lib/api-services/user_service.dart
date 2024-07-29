import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt');
    int? userId = prefs.getInt('userId');

    if (token == null || userId == null) {
      print('Token or UserId not found');
      return null;
    }

    final url = Uri.parse('http://95.163.221.72:8000/users/$userId');
    final headers = {
      'Content-Type': 'application/json',
      'JWT': '$token',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> userData = json.decode(responseBody);
        print('Received user data: $userData');
        return userData;
      } else {
        print('Failed to load user data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
