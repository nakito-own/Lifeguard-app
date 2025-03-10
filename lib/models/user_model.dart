import 'package:lifeguard/api-services/user_service.dart';

class User {
  String? name;
  String? surname;
  String? patronymic;
  String? image;
  List<String>? permissions;
  List<String>? role;

  User({this.name,
    this.surname,
    this.patronymic,
    this.permissions,
    this.image,
    this.role});

  Future<Map<String, dynamic>?> getUserData() async {
    return await UserService().getUserData();
  }
}
