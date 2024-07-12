import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_drawer_button.dart';

class AppDrawer extends StatelessWidget {

  final VoidCallback toggleTheme;

  AppDrawer({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          CustomDrawerButton(
              text: "Profile",
              icon: Icons.account_circle,
              onPressed: (){
                Navigator.pushNamed(context, '/profile');}
          ),
          CustomDrawerButton(
              icon: Icons.calendar_month,
              text: "Events",
              onPressed: (){
                Navigator.pushNamed(context, '/events');
              }),
          CustomDrawerButton(
            icon: Icons.flag_rounded,
              text: 'Shifts',
              onPressed: (){
                Navigator.pushNamed(context, '/shifts');
              }),
          CustomDrawerButton(
            icon: Icons.book_rounded,
              text: "Manuals",
              onPressed: (){
                Navigator.pushNamed(context, '/manuals');
          }),
          CustomDrawerButton(
              icon: Icons.inventory,
              text: "Inventory",
              onPressed: (){
                Navigator.pushNamed(context, '/inventory');
              }),
          CustomDrawerButton(
              text: "Switch theme",
              icon: (Icons.dark_mode),
              onPressed: (){
                toggleTheme();
              }
          ),
        ],
      ),
    );
  }
}
