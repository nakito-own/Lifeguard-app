import 'package:flutter/material.dart';
import 'package:lifeguard/screens/pofile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'styles/themes/app_light_theme.dart';
import 'styles/themes/app_dark_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifeguard Skeleton',
      theme: _isDarkTheme ? DarkTheme.theme : LightTheme.theme,
      home: HomeScreen(toggleTheme: _toggleTheme),
      routes: {
        '/home': (context) => HomeScreen(toggleTheme: _toggleTheme),
        '/details': (context) => DetailsScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
