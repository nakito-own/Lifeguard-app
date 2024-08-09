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

}
