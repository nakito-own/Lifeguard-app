import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeguard/screens/calls_screen.dart';
import 'package:lifeguard/screens/events_screen.dart';
import 'package:lifeguard/screens/inventory_screen.dart';
import 'package:lifeguard/screens/login_screen.dart';
import 'package:lifeguard/screens/manuals_screen.dart';
import 'package:lifeguard/screens/pofile_screen.dart';
import 'package:lifeguard/screens/roles_screen.dart';
import 'package:lifeguard/screens/shift_screen.dart';
import 'package:lifeguard/screens/staff_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'styles/themes/app_dark_theme.dart';
import 'styles/themes/app_light_theme.dart';
import 'package:lifeguard/utils/permissions_manager.dart';
import 'package:lifeguard/utils/keyboard_manager.dart';
import 'package:lifeguard/widgets/app-widgets/keyboard_wrapper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionsManager().initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  void _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = !_isDarkTheme;
      prefs.setBool('isDarkTheme', _isDarkTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardWrapper(
      child: MaterialApp(
        title: 'Lifeguard - МЧС',
        theme: AppLightTheme.lightTheme.copyWith(
          textTheme: GoogleFonts.nunitoTextTheme(),
        ),
        darkTheme: AppDarkTheme.darkTheme.copyWith(
          dividerColor: Colors.transparent,
          textTheme: GoogleFonts.nunitoTextTheme().apply(
            bodyColor: Colors.white,
          ),
        ),
        themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ru', 'RU'),
        ],
        locale: const Locale('ru', 'RU'),
        home: LoginScreen(toggleTheme: _toggleTheme),
        routes: {
          '/login': (context) => LoginScreen(toggleTheme: _toggleTheme),
          '/profile': (context) => ProfileScreen(toggleTheme: _toggleTheme),
          '/events': (context) => EventsScreen(toggleTheme: _toggleTheme),
          '/shifts': (context) => ShiftScreen(toggleTheme: _toggleTheme),
          '/manuals': (context) => ManualsScreen(toggleTheme: _toggleTheme),
          '/inventory': (context) => InventoryScreen(toggleTheme: _toggleTheme),
          '/calls': (context) => CallsScreen(toggleTheme: _toggleTheme),
          '/staff': (context) => StaffListScreen(toggleTheme: _toggleTheme),
          '/roles': (context) => RolesScreen(toggleTheme: _toggleTheme),
        },
      ),
    );
  }

  @override
  void dispose() {
    KeyboardManager().dispose();
    super.dispose();
  }
}
