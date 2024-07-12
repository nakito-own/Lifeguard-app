import 'package:flutter/material.dart';
import 'package:lifeguard/screens/events_screen.dart';
import 'package:lifeguard/screens/inventory_screen.dart';
import 'package:lifeguard/screens/login_screen.dart';
import 'package:lifeguard/screens/manuals_screen.dart';
import 'package:lifeguard/screens/shift_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/pofile_screen.dart';
import 'styles/themes/app_dark_theme.dart';
import 'styles/themes/app_light_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;


  @override
  void initState(){
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('isDarkTheme')?? false;
    });
  }

  void _toggleTheme() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = !_isDarkTheme;
      prefs.setBool('isDarkTheme', _isDarkTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifeguard Skeleton',
      theme: AppLightTheme.lightTheme,
      darkTheme: AppDarkTheme.darkTheme,
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: LoginScreen(toggleTheme: _toggleTheme),
      routes: {
        '/login': (context) => LoginScreen(toggleTheme: _toggleTheme),
        '/profile': (context) => ProfileScreen(toggleTheme: _toggleTheme),
        '/events': (context) => EventsScreen(toggleTheme: _toggleTheme),
        '/shifts': (context) => ShiftScreen(toggleTheme: _toggleTheme),
        '/manuals': (context) => ManualsScreen(toggleTheme: _toggleTheme),
        '/inventory': (context) => InventoryScreen(toggleTheme: _toggleTheme)
      },
    );
  }
}
