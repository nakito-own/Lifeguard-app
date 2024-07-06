import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class DetailsScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  DetailsScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      drawer: AppDrawer(toggleTheme: toggleTheme),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(arguments['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(arguments['body']),
          ],
        ),
      ),
    );
  }
}
