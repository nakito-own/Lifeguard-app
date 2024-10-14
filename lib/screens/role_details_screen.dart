import 'package:flutter/material.dart';

class RoleDetailsScreen extends StatelessWidget {
  final String roleName;
  final List<Map<String, dynamic>> permissions;

  RoleDetailsScreen({required this.roleName, required this.permissions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roleName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название роли: $roleName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Разрешения:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...permissions.map((permission) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  permission['actionName'],
                  style: TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            Text(
              'Пользователи с этой ролью:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
