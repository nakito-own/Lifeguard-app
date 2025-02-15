import 'package:flutter/material.dart';
import '../widgets/app-widgets/app_drawer.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkTheme;
  final VoidCallback toggleTheme;

  SettingsScreen({required this.isDarkTheme, required this.toggleTheme});

  @override
  _ShiftScreenState createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: 1190
              ),
              width: double.infinity,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).primaryColorLight,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Светлая тема', style: TextStyle(fontSize: 18)),
                  Spacer(),
                  Switch(
                    value: widget.isDarkTheme,
                    onChanged: (value) {
                      widget.toggleTheme();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}