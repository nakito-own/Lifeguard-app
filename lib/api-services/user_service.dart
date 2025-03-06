import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'api_keys.dart';

class UserService {
  final String apiUrl = 'http://${API_URL}:${API_PORT}';

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? cachedData = prefs.getString('cached_user_data');
    if (cachedData != null) {
      return json.decode(cachedData);
    }

    String? token = prefs.getString('jwt');
    int? userId = prefs.getInt('userId');

    if (token == null || userId == null) return null;

    final url = Uri.parse('$apiUrl/users/$userId');
    final headers = {'Content-Type': 'application/json', 'JWT': '$token'};

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final userData = json.decode(utf8.decode(response.bodyBytes));

        prefs.setString('cached_user_data', json.encode(userData));
        return userData;
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }
}
