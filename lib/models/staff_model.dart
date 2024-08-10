import 'dart:ffi';

class Staff {
  final String apply;
  final String email;
  final int id;
  final String name;
  final String nick;
  final String patronymic;
  final String phone;
  final String surname;
  final String tg;
  final String vk;

  Staff({
    required this.apply,
    required this.email,
    required this.id,
    required this.name,
    required this.nick,
    required this.patronymic,
    required this.phone,
    required this.surname,
    required this.tg,
    required this.vk,
  });

  Staff copyWith({String? newName, String? newSurname, String? newPatronymic, String? newApply, String? newEmail,
    newId,  String? newTg, String? newVk, String? newNick, String? newPhone}) {
    return Staff(
      name: newName ?? this.name,
      surname: newSurname ?? this.surname,
      patronymic: newPatronymic ?? this.patronymic,
      apply: newApply ?? this.apply,
      email: newEmail ?? this.email,
      id: newId ?? this.id,
      tg: newTg ?? this.tg,
      vk: newVk ?? this.vk,
      nick: newNick ?? this.nick,
      phone: newPhone ?? this.phone,
    );
  }

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      apply: json['apply'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nick: json['nick'] ?? '',
      patronymic: json['patronymic'] ?? '',
      phone: json['phone'] ?? '',
      surname: json['surname'] ?? '',
      tg: json['tg'] ?? '',
      vk: json['vk'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'patronymic': patronymic,
      'phone': phone,
      'email': email,
      'vk': vk,
      'tg': tg,
      'id': id,
      'nick': nick,
      'apply': apply,
    };
  }
}
