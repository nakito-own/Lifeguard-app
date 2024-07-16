import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/custom_redaction_button.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/app-widgets/custom_button.dart';
import '../widgets/app-widgets/custom_exit_button.dart';
import '../widgets/app-widgets/custom_textfield.dart';
import '../widgets/profile-widgets/profile_header_widget.dart';
import '../widgets/profile-widgets/profile_info_widget.dart';
import '../widgets/small_text.dart';


class ProfileRedactionScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  ProfileRedactionScreen({required this.toggleTheme});

  final TextEditingController Controller1 = TextEditingController();
  final TextEditingController Controller2 = TextEditingController();
  final TextEditingController Controller3 = TextEditingController();
  final TextEditingController Controller4 = TextEditingController();


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
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                      'https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200')
              ),
              SizedBox(
                height: 15,
              ),
              CustomRedactionButton(
                redactionText: 'Изменить фото профиля',
                onPressed: () {},
              ),
              ProfileHeaderWidget(FirstName: 'Яромир',
                  SecondName: 'Андриянов',
                  Patronymic: 'Ильич',
                  Post1: 'Инструктор',
                  Post2: 'Спасатель'),
              SizedBox(
                height: 10,
              ),
              SmallText(some_text: 'Основная информация'),
              ProfileInfoWidget(Role: 'Отрядик: ',
                  GroupNumber: 'Феникс',
                  Another: 'Класс:',
                  Position: 'Генерал'),
              SmallText(
                  some_text: '*у вас недостаточно прав для редактирования основной информации'),
              SizedBox(
                height: 25,
              ),
              SmallText(some_text: 'Личные данные'),
              SizedBox(
                height: 15,
              ),
              CustomTextField(text: '8 800 555 35 35 ', widthSize: MediaQuery.of(context).size.width * 0.9,
                labelText: 'Телефон',
                isPass: false,
                controller: Controller1,
                ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(text: 'https://vk.com/', widthSize: MediaQuery.of(context).size.width * 0.9,
                labelText: 'Ссылка в VK',
                isPass: false,
                controller: Controller2,
                ), SizedBox(
                height: 15,
              ),
              CustomTextField(text: 'https://t.me/', widthSize: MediaQuery.of(context).size.width * 0.9,
                labelText: 'Ссылка в TG',
                isPass: false,
                controller: Controller3,
                ), SizedBox(
                height: 15,
              ),
              CustomTextField(text: 'https://mail.ru/', widthSize: MediaQuery.of(context).size.width * 0.9,
                labelText: 'Почта',
                isPass: false,
                controller: Controller4,
               ), SizedBox(height: 20,),
              CustomButton(buttonText: 'Сохранить', MiniButton: false, onPressed: () {
                print('${Controller1.text}, ${Controller2.text}, ${Controller3.text}, ${Controller4.text}');
               },),
              SizedBox(height: 20,),
              ButtonExit(text: 'Выйти', onPressed: () {
                Controller1.clear();
                Controller2.clear();
                Controller3.clear();
                Controller4.clear();
                Navigator.pushNamed(context, '/profile');
              },
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      );
    }
  }
