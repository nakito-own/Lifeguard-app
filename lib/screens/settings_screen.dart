import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../styles/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: const Text('Настройки')),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: 1170
              ),
              width: double.infinity,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorScheme.of(context).primary
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Тёмная тема:', style: TextTheme.of(context).bodyLarge),
                  Spacer(),
                  Switch(
                    value: themeProvider.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
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
