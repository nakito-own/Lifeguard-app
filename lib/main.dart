import 'package:flutter/material.dart';
import 'package:lifeguard/screens/calls_screen.dart';
import 'package:lifeguard/screens/events_screen.dart';
import 'package:lifeguard/screens/inventory_screen.dart';
import 'package:lifeguard/screens/login_screen.dart';
import 'package:lifeguard/screens/manuals_screen.dart';
import 'package:lifeguard/screens/pofile_screen.dart';
import 'package:lifeguard/screens/roles_screen.dart';
import 'package:lifeguard/screens/settings_screen.dart';
import 'package:lifeguard/screens/shift_screen.dart';
import 'package:lifeguard/screens/staff_screen.dart';
import 'package:lifeguard/styles/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lifeguard/utils/permissions_manager.dart';
import 'package:lifeguard/styles/themes/app_dark_theme.dart';
import 'package:lifeguard/styles/themes/app_light_theme.dart';
import 'package:lifeguard/widgets/app-widgets/bug_report_button.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionsManager().initialize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      builder: (context, child){
        return Stack(
          children: [
            if (child != null) child,
            Positioned(
              bottom: 32,
                right: 16,
                child: BugReportButton())
          ],
        );
      },
      title: 'Lifeguard - МЧС',
      theme: AppLightTheme.theme,
      darkTheme: AppDarkTheme.theme,
      themeMode: themeProvider.themeMode,
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
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/profile': (context) => ProfileScreen(),
        '/events': (context) => EventsScreen(),
        '/shifts': (context) => ShiftScreen(),
        '/manuals': (context) => ManualsScreen(),
        '/inventory': (context) => InventoryScreen(),
        '/calls': (context) => CallsScreen(),
        '/staff': (context) => StaffListScreen(),
        '/roles': (context) => RolesScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
