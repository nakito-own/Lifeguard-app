import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_drawer_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_exit_button.dart';
import 'package:lifeguard/utils/permissions_manager.dart';
import 'package:lifeguard/models/user_model.dart';

import '../../api-services/image_service.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback toggleTheme;
  final PermissionsManager permissionsManager = PermissionsManager();

  AppDrawer({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 42),
            child: FutureBuilder<Map<String, dynamic>?>(
              future: User().getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text('No user data found')),
                  );
                } else {
                  final userData = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        FutureBuilder<Image>(
                          future: userData['image'] != null && userData['image'].isNotEmpty
                              ? ImageService().fetchImage('user', userData['image'])
                              : Future.error('No image available'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircleAvatar(radius: 40, child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return CircleAvatar(radius: 40, child: Icon(Icons.account_circle, size: 70));
                            } else {
                              return CircleAvatar(radius: 40, backgroundImage: snapshot.data?.image);
                            }
                          },
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
                                'Role',
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
                          icon: Icons.call,
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
                          icon: Icons.construction,
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
                      if (permissions.contains('permissions list'))
                        CustomDrawerButton(
                          icon: Icons.manage_accounts,
                          text: 'Роли',
                          onPressed: () {
                            Navigator.pushNamed(context, '/roles');
                          },
                        ),
                      CustomDrawerButton(
                        text: "Сменить тему",
                        icon: Icons.dark_mode,
                        onPressed: () {
                          toggleTheme();
                        },
                      ),
                      CustomDrawerButton(
                        text: "Настройки",
                        icon: Icons.settings,
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
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
