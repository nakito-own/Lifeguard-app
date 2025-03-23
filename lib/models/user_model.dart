import 'package:lifeguard/api-services/user_service.dart';

class User {
  String? name;
  String? surname;
  String? patronymic;

  List<String>? permissions;
  List<String>? role;

  User({this.name, this.surname, this.patronymic, this.permissions, this.role});

  Future<Map<String, dynamic>?> getUserData() async {
    return await UserService().getUserData();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      patronymic: json['patronymic'],
      permissions: List<String>.from(json['permissions'] ?? []),
      role: List<String>.from(json['role'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'patronymic': patronymic,
      'permissions': permissions,
      'role': role,
    };
  }

  User copyWith({
    String? name,
    String? surname,
    String? patronymic,
    List<String>? permissions,
    List<String>? role,
  }) {
    return User(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      patronymic: patronymic ?? this.patronymic,
      permissions: permissions ?? this.permissions,
      role: role ?? this.role,
    );
  }
}
