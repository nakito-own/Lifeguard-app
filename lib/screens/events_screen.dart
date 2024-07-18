import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/events-widgets/calendar_widget.dart';
import '../widgets/app-widgets/app_drawer.dart';

class EventsScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  EventsScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мероприятия'),
      ),
      drawer: AppDrawer(toggleTheme: toggleTheme),
      body: Padding(
          padding: EdgeInsets.only(top: 10, bottom:10, left:10, right:10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              CalendarWidget(toggleTheme: toggleTheme)
              ]
          )
      )
    );
  }
}
