import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../styles/themes/app_dark_theme.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  HomeScreen({required this.toggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        decoration: Theme.of(context).brightness == Brightness.dark
            ? DarkTheme.scaffoldGradientBackground
            : null,
        child: FutureBuilder<List<dynamic>>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['title'], style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color)),
                    subtitle: Text(snapshot.data![index]['body'], style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: snapshot.data![index],
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
