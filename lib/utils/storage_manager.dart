import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  static Future<void> savePermissions(List<String> permissions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('permissions', permissions);
  }

  static Future<List<String>?> getPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('permissions');
  }
}
