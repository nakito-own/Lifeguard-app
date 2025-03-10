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
      appBar: AppBar(title: Text('Настройки')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(
                    maxWidth: 1170
                ),
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorScheme.of(context).primary
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('  Тёмная тема:', style: TextTheme.of(context).bodyMedium),
                    Spacer(),
                    Switch(
                      value: themeProvider.themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        themeProvider.toggleTheme(value);
                      },
                      activeTrackColor: ColorScheme.of(context).secondary,
                    ),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: 1170
                ),
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorScheme.of(context).primary
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('  Лицензия', style: TextTheme.of(context).bodyMedium),
                    Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(Icons.info))
                  ],
                ),
              ),
              Spacer(),
              Text(
                'Development from NES ltd. \nProvided by @Goosendra & @nakito-own',
                style: TextTheme.of(context).bodySmall)
            ],
          ),
        ),
      ),
    );
  }
}
