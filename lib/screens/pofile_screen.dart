import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  ProfileScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: AppDrawer(toggleTheme: toggleTheme),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://sun9-51.userapi.com/impg/Ig98IXgnt40sxJJhi7TdmgOZ5vFckg-h_QF3bw/ZUa76befUXY.jpg?size=487x467&quality=96&sign=cada24b4d5d4cf001a0a2bd1febc0b07&type=album'),
            ),
            SizedBox(height: 16),
            Text('Kirill Kileevych', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('user@example.com'),
          ],
        ),
      ),
    );
  }
}
