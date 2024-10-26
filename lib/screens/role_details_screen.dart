import 'package:flutter/material.dart';

class RoleDetailsScreen extends StatelessWidget {
  final String roleName;
  final List<Map<String, dynamic>> permissions;

  RoleDetailsScreen({required this.roleName, required this.permissions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали роли'), // Название роли убрано из AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1400), // Максимальная ширина 1400 пикселей
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roleName, // Название роли сверху крупным текстом
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Разрешения:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ...permissions.map((permission) {
                  return Container(
                    width: double.infinity, // Растягивает контейнер по всей доступной ширине
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
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
                SizedBox(height: 10),
                // Здесь можно добавить информацию о пользователях
              ],
            ),
          ),
        ),
      ),
    );
  }
}
