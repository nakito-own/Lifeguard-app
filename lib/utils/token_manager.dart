import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  factory TokenManager() {
    return _instance;
  }

  TokenManager._internal();

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }

  Map<String, dynamic>? decodeToken(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }
}
