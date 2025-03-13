import 'package:flutter/material.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/screens/staff_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api-services/image_service.dart';

Future<int?> getUserId() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}

class StaffCard extends StatelessWidget {
  final Staff staff;

  final prefs = SharedPreferences.getInstance();
  StaffCard({required this.staff});

  @override
  Widget build(BuildContext context) {
    final Color cardColor;
    if (staff.id == getUserId()) {
      cardColor = ColorScheme.of(context).secondary;
    } else {
      cardColor = ColorScheme.of(context).primary;
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1210),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StaffProfileScreen(
                    staffId: staff.id,
                    staff: staff,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 0.1,
              margin: EdgeInsets.all(6),
              color: cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 12),
                  leading: FutureBuilder<Image>(
                    future: staff.avatar.isNotEmpty
                        ? ImageService().fetchImage('users', staff.avatar)
                        : Future.error('No image available'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircleAvatar(radius: 25, child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return CircleAvatar(radius: 25, child: Icon(Icons.account_circle, size: 50));
                      } else {
                        return CircleAvatar(radius: 25, backgroundImage: snapshot.data?.image);
                      }
                    },
                  ),
                  title: Text('${staff.surname} ${staff.name} ${staff.patronymic}', style: TextTheme.of(context).bodyMedium),
                  subtitle: Text(staff.nick, style: TextTheme.of(context).bodySmall),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

