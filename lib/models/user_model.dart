import 'package:lifeguard/api-services/user_service.dart';

class User {
  String? name;
  String? surname;
  String? patronymic;

  List<String>? permissions;

  User({this.name, this.surname, this.patronymic, this.permissions});

  Future<Map<String, dynamic>?> getUserData() async {
    return await UserService().getUserData();
  }
}
