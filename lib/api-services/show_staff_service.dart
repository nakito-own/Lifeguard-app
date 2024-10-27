import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifeguard/models/staff_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_keys.dart';

class ShowStaffService {
  final String apiUrl = 'http://95.163.221.72:8000/users';

  Future<Staff> fetchStaffById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('http://${API_URL}:${API_PORT}/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'JWT': token,
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonResponse = json.decode(responseBody);

      print('API Response: $jsonResponse');

      jsonResponse.forEach((key, value) {
        if (value == null) {
          print('Null value found for key: $key');
        }
      });

      return Staff.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load staff');
    }
  }
}
