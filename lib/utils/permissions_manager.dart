import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class PermissionsManager {
  static final PermissionsManager _instance = PermissionsManager._internal();

  factory PermissionsManager() {
    return _instance;
  }

  PermissionsManager._internal();

  List<String>? _permissions;
  String? _jwt;
  int? _userId;

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _jwt = prefs.getString('jwt');
    _permissions = prefs.getStringList('permissions');
    _userId = prefs.getInt('userId');
  }
  Future<void> saveUserData(String token, List<Map<String, dynamic>> permissions, int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> permissionsList = permissions.map((perm) => perm['permissionName'].toString()).toList();

    await prefs.setString('jwt', token);
    await prefs.setStringList('permissions', permissionsList);
    await prefs.setInt('userId', userId);

    _jwt = token;
    _permissions = permissionsList;
    _userId = userId;
  }

  Future<String?> getToken() async {
    if (_jwt == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _jwt = prefs.getString('jwt');
    }
    return _jwt;
  }

  Future<List<String>?> getPermissions() async {
    if (_permissions == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _permissions = prefs.getStringList('permissions');
    }
    return _permissions;
  }

  Future<int?> getUserId() async {
    if (_userId == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _userId = prefs.getInt('userId');
    }
    return _userId;
  }

  Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.remove('permissions');
    await prefs.remove('userId');

    _jwt = null;
    _permissions = null;
    _userId = null;
  }

  Map<String, dynamic>? decodeToken(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }

  bool hasPermission(String permission) {
    if (_permissions == null) {
      throw Exception('Доступы не загружены');
    }
    return _permissions!.contains(permission);
  }
}
