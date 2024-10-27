import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/role_model.dart';
import 'api_keys.dart';

class RoleService {

  Future<List<RoleModel>> getRoles() async {
    final jwtToken = await _getJwtToken();

    final response = await http.get(
      Uri.parse('http://${API_URL}:${API_PORT}/role'),
      headers: {
        'JWT': '$jwtToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = json.decode(utf8Response);
      return jsonResponse.map((role) => RoleModel.fromJson(role)).toList();
    } else {
      throw Exception('Error to load roles');
    }
  }

  Future<Map<String, dynamic>> getRoleById(int id) async {
    final jwtToken = await _getJwtToken();

    final response = await http.get(
      Uri.parse('http://${API_URL}:${API_PORT}/role/$id'),
      headers: {
        'JWT': '$jwtToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      return json.decode(utf8Response);
    } else {
      throw Exception('Error to load role');
    }
  }

  Future<String?> _getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }
}
