import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lifeguard/models/Item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventoryService {
  final String apiUrl = 'http://95.163.221.72:8000/inventory';

  Future<List<Item>> fetchItem() async {
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
      return jsonResponse.map((item) => Item.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Ошибка при загрузке пользователя');
    }
  }
}
