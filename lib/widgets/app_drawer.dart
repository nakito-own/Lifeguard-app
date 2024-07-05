import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/custom_drawer_button.dart';

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
              text: "Home [DEBUG]",
              icon: Icons.home,
              onPressed: (){
                Navigator.pushNamed(context, '/home');}
          ),
          CustomDrawerButton(
              text: "Details [DEBUG]",
              icon: Icons.details,
              onPressed: (){
                Navigator.pushNamed(context, '/details', arguments: {
                  'title': 'Example Title',
                  'body': 'Example Body',
                });}
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
