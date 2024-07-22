import 'package:flutter/material.dart';
import '../widgets/app-widgets/app_drawer.dart';

class InventoryScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  InventoryScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Оборудоване'),
        ),
        drawer: AppDrawer(toggleTheme: toggleTheme),
        body: Padding(
            padding: EdgeInsets.only(top: 40, bottom:10, left:10, right:10),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Тут будет жесткий инветарь',
                )
            )
        )
    );
  }
}
