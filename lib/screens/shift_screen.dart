import 'package:flutter/material.dart';
import '../widgets/app-widgets/app_drawer.dart';

class ShiftScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  ShiftScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Смены'),
        ),
        drawer: AppDrawer(toggleTheme: toggleTheme),
        body: Padding(
            padding: EdgeInsets.only(top: 40, bottom:10, left:10, right:10),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Смены ебать',
                )
            )
        )
    );
  }
}
