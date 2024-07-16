import 'package:flutter/material.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/profile-widgets/profile_header_widget.dart';
import '../widgets/profile-widgets/profile_info_widget.dart';
import '../widgets/profile-widgets/my_info.dart';
import '../widgets/small_text.dart';
import 'package:lifeguard/widgets/transparent_button.dart';


class ProfileScreen extends StatelessWidget {

  final VoidCallback toggleTheme;

  ProfileScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      drawer: AppDrawer(toggleTheme: toggleTheme),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(height: 45),
            CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200')
        ),
            ProfileHeaderWidget(
                FirstName: 'Яромир',
                SecondName: 'Андриянов',
                Patronymic: 'Ильич',
                Post1: 'Инструктор',
                Post2: 'Спасатель'),
            SizedBox(height: 30),
            SmallText(some_text: 'Основная информация'),
            ProfileInfoWidget(Role: 'Группы',
              GroupNumber: '123123123',
                Position: 'Гейнерал',
                Another: 'Класс:'
                ),
            SizedBox(
              height: 10,
            ),
            SmallText(some_text: 'Личные данные'),
            MyInfo(
                phone: '8-800-555-35-35',
                VK_Link: 'https://vk.com/gooseandra',
                TG_Link: 'https://t.me/panovv',
                Mail_Link: 'https://mail.ru/'
            ),
            SizedBox(height: 10,),
            TransparentButton(text: 'Редактировать личные данные', onPressed: ()
              {
                Navigator.pushNamed(context, '/redaction');
              },),
            SizedBox(height: 10,),
          ],

        ),
      ),
    );
  }
}
