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
              text: "Home",
              icon: Icons.home,
              onPressed: (){
                Navigator.pushNamed(context, '/home');}
          ),
          CustomDrawerButton(
              text: "Details",
              icon: Icons.details,
              onPressed: (){
                Navigator.pushNamed(context, '/details', arguments: {
                  'title': 'Example Title',
                  'body': 'Example Body',
                });}
          ),
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
