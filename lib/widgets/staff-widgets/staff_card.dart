import 'package:flutter/material.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/screens/staff_profile_screen.dart';
import '../../api-services/image_service.dart';

class StaffCard extends StatelessWidget {
  final Staff staff;

  StaffCard({required this.staff});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkTheme ? Colors.white10 : Colors.grey[200];

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
              margin: EdgeInsets.all(6),
              color: cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 0),
                  leading: FutureBuilder<Image>(
                    future: staff.avatar != null && staff.avatar.isNotEmpty
                        ? ImageService().fetchImage('user', staff.avatar)
                        : Future.error('No image available'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircleAvatar(radius: 30, child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return CircleAvatar(radius: 30, child: Icon(Icons.account_circle, size: 30));
                      } else {
                        return CircleAvatar(radius: 30, backgroundImage: snapshot.data?.image);
                      }
                    },
                  ),
                  title: Text('${staff.surname} ${staff.name} ${staff.patronymic}'),
                  subtitle: Text(staff.nick),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
