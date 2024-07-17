import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifeguard/utils/token_manager.dart';

class UserService {
  Future<Map<String, dynamic>?> getUserData() async {

    TokenManager tokenManager = TokenManager();
    String? token = await tokenManager.getToken();
    int? userId = await tokenManager.getUserId();

    if (token == null || userId == null) {
      //Обработка типа когда что то не то пошло
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
        return json.decode(response.body);
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
