import 'package:flutter/material.dart';

class RoleDetailsScreen extends StatelessWidget {
  final String roleName;
  final List<Map<String, dynamic>> permissions;

  RoleDetailsScreen({required this.roleName, required this.permissions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.brightness == Brightness.dark
        ? theme.colorScheme.surface.withOpacity(0.3)
        : theme.colorScheme.primaryContainer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Детали роли'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roleName,
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
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      permission['actionName'],
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
