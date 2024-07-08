import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/custom_button.dart';
import 'package:lifeguard/widgets/custom_textfield.dart';
import '../widgets/app_drawer.dart';
import '../widgets/profile_info_widget.dart';

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
            CustomButtonPush(
              text: 'Добавить мероприятие', onPressed: () {},
            ),
            CustomTextfield(
            text: 'Логин',  onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextfield(
            text: 'Пароль',  onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            ProfileInfoWidget(text1: '123 132312',
            text2: 'Генерал',
            ),
          ],
        ),
      ),
    );
  }
}
