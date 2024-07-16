import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_drawer_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_exit_button.dart';


class AppDrawer extends StatelessWidget {

  final VoidCallback toggleTheme;

  AppDrawer({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            /*decoration: BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.transparent
              ))
            ),*/
            child: Row(
              children:[
                CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200'),
              ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Андриянов Яромир Ильич',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                      fontSize: 14,
                    ),),
                    Text('Инструктор',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),),
                  ],
                ),
              ],
            ),
          ),
          CustomDrawerButton(
              text: "Профиль",
              icon: Icons.account_circle,
              onPressed: (){
                Navigator.pushNamed(context, '/profile');}
          ),
          CustomDrawerButton(
              icon: Icons.calendar_month,
              text: "Мероприятия",
              onPressed: (){
                Navigator.pushNamed(context, '/events');
              }),
          CustomDrawerButton(
            icon: Icons.flag_rounded,
              text: 'Смены',
              onPressed: (){
                Navigator.pushNamed(context, '/shifts');
              }),
          CustomDrawerButton(
            icon: Icons.book_rounded,
              text: "Методички",
              onPressed: (){
                Navigator.pushNamed(context, '/manuals');
          }),
          CustomDrawerButton(
              icon: Icons.inventory,
              text: "Инвентарь",
              onPressed: (){
                Navigator.pushNamed(context, '/inventory');
              }),
          CustomDrawerButton(
              text: "Сменить тему",
              icon: (Icons.dark_mode),
              onPressed: (){
                toggleTheme();
              }),
          SizedBox( height: 150,),
          ButtonExit(text: 'Выйти', onPressed: (){
            Navigator.pushNamed(context, '/login');
          }),

        ],
      ),
    );
  }
}
