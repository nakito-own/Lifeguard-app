import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifeguard/models/staff_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_keys.dart';

class StaffService {
  Future<List<Staff>> fetchStaff() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    final response = await http.get(
      Uri.parse('http://${API_URL}:${API_PORT}/users'),
      headers: {
        'Content-Type': 'application/json',
        'JWT': '$token',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = json.decode(responseBody);
      return jsonResponse.map((staff) => Staff.fromJson(staff as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<Map<String, dynamic>> createStaff(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    final response = await http.post(
      Uri.parse('http://${API_URL}:${API_PORT}/users'),
      headers: {
        'Content-Type': 'application/json',
        'JWT': '$token',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      final int userId = int.parse(response.body);
      return {
        'success': true,
        'userId': userId,
        'message': 'Пользователь успешно создан'
      };
    } else {
      return {
        'success': false,
        'message': response.body
      };
    }
  }

  Future<Map<String, dynamic>> updateStaff(int staffId, Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    final response = await http.post(
      Uri.parse('http://${API_URL}:${API_PORT}/users/$staffId'),
      headers: {
        'Content-Type': 'application/json',
        'JWT': '$token',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Данные успешно обновлены',
      };
    } else {
      return {
        'success': false,
        'message': response.body,
      };
    }
  }
  Future<Map<String, dynamic>> deleteStaff(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    final String url = 'http://$API_URL:$API_PORT/users/$userId';

    final Map<String, dynamic> body = {
      'fired': DateTime.now().toString(),
    };

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'JWT': '$token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return {'success': true, 'message': 'Пользователь удалён'};
    } else {
      return {'success': false, 'message': response.body};
    }
  }
}
