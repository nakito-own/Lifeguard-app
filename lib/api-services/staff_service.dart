import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifeguard/models/staff_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffService {
  final String apiUrl = 'http://95.163.221.72:8000/users';

  Future<List<Staff>> fetchStaff() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    final response = await http.get(
      Uri.parse(apiUrl),
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
      throw Exception('Failed to load staff');
    }
  }
}
