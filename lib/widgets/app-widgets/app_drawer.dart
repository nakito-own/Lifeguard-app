import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_drawer_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_exit_button.dart';
import 'package:lifeguard/utils/permissions_manager.dart';
import 'package:lifeguard/models/user_model.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback toggleTheme;
  final PermissionsManager permissionsManager = PermissionsManager();

  AppDrawer({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          FutureBuilder<Map<String, dynamic>?>(
            future: User().getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return DrawerHeader(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return DrawerHeader(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return DrawerHeader(
                  child: Center(child: Text('No user data found')),
                );
              } else {
                final userData = snapshot.data!;
                return DrawerHeader(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                            'https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200'),
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${userData['surname']} ${userData['name']} ${userData['patronymic']}',
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '${userData['rank']}',
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Expanded(
            child: FutureBuilder<List<String>?>(
              future: permissionsManager.getPermissions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No permissions found'));
                } else {
                  final permissions = snapshot.data!;
                  return ListView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    children: <Widget>[
                      CustomDrawerButton(
                        text: "Профиль",
                        icon: Icons.account_circle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                      //if (permissions.contains('events list'))
                        CustomDrawerButton(
                          icon: Icons.calendar_month,
                          text: "Мероприятия",
                          onPressed: () {
                            Navigator.pushNamed(context, '/events');
                          },
                        ),
                      if (permissions.contains('crew list'))
                        CustomDrawerButton(
                          icon: Icons.flag_rounded,
                          text: 'Смены',
                          onPressed: () {
                            Navigator.pushNamed(context, '/shifts');
                          },
                        ),
                      if (permissions.contains('call list'))
                        CustomDrawerButton(
                          icon: Icons.phone_callback,
                          text: 'Вызовы',
                          onPressed: () {
                            Navigator.pushNamed(context, '/calls');
                          },
                        ),
                      if (permissions.contains('manuals list'))
                        CustomDrawerButton(
                          icon: Icons.book_rounded,
                          text: "Методички",
                          onPressed: () {
                            Navigator.pushNamed(context, '/manuals');
                          },
                        ),
                      if (permissions.contains('inventory list'))
                        CustomDrawerButton(
                          icon: Icons.inventory,
                          text: "Оборудование",
                          onPressed: () {
                            Navigator.pushNamed(context, '/inventory');
                          },
                        ),
                      if (permissions.contains('user list'))
                        CustomDrawerButton(
                          icon: Icons.group,
                          text: "Сотрудники",
                          onPressed: () {
                            Navigator.pushNamed(context, '/staff');
                          },
                        ),
                      CustomDrawerButton(
                        text: "Сменить тему",
                        icon: Icons.dark_mode,
                        onPressed: () {
                          toggleTheme();
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: ButtonExit(
              text: 'Выйти',
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
