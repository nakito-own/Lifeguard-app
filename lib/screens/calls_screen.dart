import 'package:flutter/material.dart';
import '../widgets/app-widgets/app_drawer.dart';

class CallsScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  CallsScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Вызовы'),
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
                ]
            )
        )
    );
  }
}
