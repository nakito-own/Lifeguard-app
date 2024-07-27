import 'package:flutter/material.dart';
import 'package:lifeguard/models/staff_model.dart';

class StaffCard extends StatelessWidget {

  final Staff staff;

  StaffCard({required this.staff});

  @override
  Widget build(BuildContext context) {

    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkTheme ? Colors.grey[900] : Colors.blue;

    return GestureDetector(
      onTap: () {
        // Настроить переход профилю конкретного юзера
      },
      child: Card(
        margin: EdgeInsets.all(10),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200'), // Замените на URL аватара сотрудника
            ),
            title: Text('${staff.surname} ${staff.name} ${staff.patronymic}'),
            subtitle: Text(staff.nick),
          ),
        ),
      ),
    );
  }
}
