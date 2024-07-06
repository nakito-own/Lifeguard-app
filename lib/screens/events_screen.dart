import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class EventsScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  EventsScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    //final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      drawer: AppDrawer(toggleTheme: toggleTheme),
      body: Padding(
          padding: EdgeInsets.only(top: 40, bottom:10, left:10, right:10),
          child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                  'Its Events screen',
              )
          )
      )
    );
  }
}
