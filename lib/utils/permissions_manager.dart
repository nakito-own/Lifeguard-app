import 'package:shared_preferences/shared_preferences.dart';

class PermissionsManager {
  static final PermissionsManager _instance = PermissionsManager._internal();
  factory PermissionsManager() => _instance;

  PermissionsManager._internal();

  SharedPreferences? prefs;

  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUserData(String token, List<Map<String, dynamic>> permissionsList, int userId) async {
    await _ensureInitialized();
    await prefs!.setString('jwt', token);
    await prefs!.setInt('userId', userId);

    List<String> permissionsNames = permissionsList.map((perm) => perm['permissionName'].toString()).toList();
    await prefs!.setStringList('permissions', permissionsNames);
  }

  Future<String?> getToken() async {
    await _ensureInitialized();
    return prefs!.getString('jwt');
  }

  Future<int?> getUserId() async {
    await _ensureInitialized();
    return prefs!.getInt('userId');
  }

  Future<List<String>?> getPermissions() async {
    await _ensureInitialized();
    return prefs!.getStringList('permissions');
  }

  Future<String?> getRank() async {
    await _ensureInitialized();
    return prefs!.getString('rank');
  }

  Future<bool> hasPermission(String permission) async {
    await _ensureInitialized();
    List<String>? permissions = await getPermissions();
    return permissions != null && permissions.contains(permission);
  }

  Future<void> _ensureInitialized() async {
    if (prefs == null) {
      await initialize();
    }
  }
}
