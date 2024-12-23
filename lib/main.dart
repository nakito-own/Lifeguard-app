import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'styles/themes/app_dark_theme.dart';
import 'styles/themes/app_light_theme.dart';
import 'utils/permissions_manager.dart';
import 'styles/themes/theme_service.dart';
import 'screens/calls_screen.dart';
import 'screens/events_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/login_screen.dart';
import 'screens/manuals_screen.dart';
import 'screens/pofile_screen.dart';
import 'screens/roles_screen.dart';
import 'screens/shift_screen.dart';
import 'screens/staff_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionsManager().initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return MaterialApp(
      title: 'Lifeguard',
      theme: AppLightTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      darkTheme: AppDarkTheme.darkTheme.copyWith(
        textTheme: GoogleFonts.nunitoTextTheme().apply(
          bodyColor: Colors.white,
        ),
      ),
      themeMode: themeService.themeMode,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      locale: const Locale('ru', 'RU'),
      home: LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/events': (context) => const EventsScreen(),
        '/shifts': (context) => const ShiftScreen(),
        '/manuals': (context) => const ManualsScreen(),
        '/inventory': (context) => const InventoryScreen(),
        '/calls': (context) => const CallsScreen(),
        '/staff': (context) => const StaffListScreen(),
        '/roles': (context) => const RolesScreen(),
      },
    );
  }
}
