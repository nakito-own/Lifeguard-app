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
              backgroundImage: NetworkImage('https://sun9-50.userapi.com/impg/bTJey_bCc3FwC2gb7pZsOw-0i-dYUONmV6kSow/d5gQSDyGbao.jpg?size=810x1080&quality=95&sign=d229f54c186cd28adcf5377d8cc730d2&type=album'),
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
