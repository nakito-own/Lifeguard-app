import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifeguard/models/shift_model.dart';
import 'api_keys.dart';

class ShiftService {

  Future<List<Shift>> fetchShifts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    final response = await http.get(
      Uri.parse('http://${API_URL}:${API_PORT}/crews'),
      headers: {
        'Content-Type': 'application/json',
        'JWT': '$token',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = json.decode(responseBody);
      return jsonResponse.map((shift) => Shift.fromJson(shift as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load shifts');
    }
  }

  Future<Map<String, dynamic>> createShift(Map<String, dynamic> shiftData) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    final response = await http.post(
      Uri.parse('http://${API_URL}:${API_PORT}/crews'),
      headers: {
        'Content-Type': 'application/json',
        'JWT': '$token',
      },
      body: jsonEncode(shiftData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'success': true,
        'message': 'Смена успешно создана',
      };
    } else {
      return {
        'success': false,
        'message': response.body,
      };
    }
  }
}