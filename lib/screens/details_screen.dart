import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/custom_button.dart';
import 'package:lifeguard/widgets/custom_textfield.dart';
import '../widgets/app_drawer.dart';
import '../widgets/profile_info_widget.dart';
import '../widgets/my_info.dart';

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
            CustomButton(
              buttonText: 'Добавить мероприятие', onPressed: () {},
            ),
            CustomTextField(
            text: 'Логин',  onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
            text: 'Пароль',  onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            ProfileInfoWidget(GroupNumber: '123 132312',
            Position: 'Генерал',
            ),
            MyInfo(phone: '8-800-555-35-35', VK_Link: 'https://vk.com/gooseandra',
                TG_Link: 'https://t.me/panovv', Mail_Link: 'https://e.mail.ru/inbox/')
          ],
        ),
      ),
    );
  }
}
