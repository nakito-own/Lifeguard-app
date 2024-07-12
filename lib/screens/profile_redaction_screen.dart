import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/custom_button.dart';
import 'package:lifeguard/widgets/custom_components.dart';
import 'package:lifeguard/widgets/custom_redaction_button.dart';
import 'package:lifeguard/widgets/custom_textfield.dart';
import '../widgets/app_drawer.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/profile_info_widget.dart';
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
              ProfileHeaderWidget(FIO: 'Андриянов Яромир Ильич',
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
                height: 10,
              ),
             /*  ValueListenableBuilder<String>(
            valueListenable: text1,
               builder: (context, value, child) {
                 return CustomTextField(hintText: '8 800 555 35 35 ',
                   labelText: 'Телефон',
                   text: text1.value,
                  onTextChanged: (text) {
                     text1.value = text;
                   },
                 );
               },
            ),
            ValueListenableBuilder<String>(
              valueListenable: text2,
              builder: (context, value, child) {
                return CustomTextField(hintText: 'ВК ',
                  labelText: 'ВК',
                  onTextChanged: (text) {
                    text2.value = text;
                  },);
              },
            ),
            ValueListenableBuilder<String>(
              valueListenable: text3,
              builder: (context, value, child) {
                return CustomTextField(hintText: 'ТГ ',
                  labelText: 'ТГ',
                  onTextChanged: (text) {
                    text3.value = text;
                  },);
              },
            ),
            ValueListenableBuilder<String>(
              valueListenable: text4,
              builder: (context, value, child) {
                return CustomTextField(hintText: 'МАИЛ ',
                  labelText: 'Почта',
                  onTextChanged: (text) {
                    text4.value = text;
                  },);
              },
            ),*/
              CustomTextField(hintText: '8 800 555 35 35 ',
                labelText: 'Телефон',
                NewText: (value) {
                  Controller1.text = value;
                },),
              SizedBox(
                height: 20,
              ),
              CustomTextField(hintText: 'https://vk.com/',
                labelText: 'Ссылка в VK',
                NewText: (value) {
                  Controller2.text = value;
                },), SizedBox(
                height: 20,
              ),
              CustomTextField(hintText: 'https://t.me/',
                labelText: 'Ссылка в TG',
                NewText: (value) {
                  Controller3.text = value;
                },), SizedBox(
                height: 20,
              ),
              CustomTextField(hintText: 'https://mail.ru/',
                labelText: 'Почта',
                NewText: (value) {
                  Controller4.text = value;
                },), SizedBox(
                height: 20,
              ),
              CustomButton(buttonText: 'Сохранить', onPressed: () {
                print('${Controller1.text}, ${Controller2.text}, ${Controller3.text}, ${Controller4.text}');
               },),
              ButtonExit(text: 'Выйти', onPressed: () {
                Controller1.clear();
                Controller2.clear();
                Controller3.clear();
                Controller4.clear();
                Navigator.pushNamed(context, '/profile');
              },
              ),

              /* MyInfo(phone: '8-800-555-35-35', VK_Link: 'https://vk.com/gooseandra',
                TG_Link: 'https://t.me/panovv', Mail_Link: 'https://mail.ru/'),
            TransparentButton(text: 'Редактировать личные данные')*/
            ],
          ),
        ),
      );
    }
  }
