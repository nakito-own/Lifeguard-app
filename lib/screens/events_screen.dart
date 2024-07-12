import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/custom_button.dart';
import 'package:lifeguard/widgets/custom_textfield.dart';
import '../widgets/app_drawer.dart';

class EventsScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  EventsScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      drawer: AppDrawer(toggleTheme: toggleTheme),
      body: Padding(
          padding: EdgeInsets.only(top: 10, bottom:10, left:10, right:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                  buttonText: 'Добавить мероприятие',
                  MiniButton: false,
                  onPressed: (){
                    Navigator.pushNamed(context, '/home');
                  }),
              SizedBox(height: 20),
            ],
          )
      )
    );
  }
}
