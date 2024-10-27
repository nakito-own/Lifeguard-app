import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifeguard/models/Item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_keys.dart';

class InventoryService {
  final String apiUrl = 'http://${API_URL}:${API_PORT}/inventory';

  Future<List<Item>> fetchItem() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');

    if (token == null) {
      throw Exception('Token is null');
    }


    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'JWT': '$token',
      },
    );

    if (response.statusCode == 200) {

      print('Response body: ${response.body}');

      final String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> jsonResponse = json.decode(responseBody);
      return jsonResponse.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Error to load user data');
    }
  }
}
