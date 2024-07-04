import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/pofile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
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
      home: HomeScreen(toggleTheme: _toggleTheme),
      routes: {
        '/home': (context) => HomeScreen(toggleTheme: _toggleTheme),
        '/details': (context) => DetailsScreen(toggleTheme: _toggleTheme),
        '/profile': (context) => ProfileScreen(toggleTheme: _toggleTheme),
      },
    );
  }
}
