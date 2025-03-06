import 'package:flutter/material.dart';
import 'package:lifeguard/models/staff_model.dart';
import 'package:lifeguard/api-services/show_staff_service.dart';
import 'package:lifeguard/widgets/profile-widgets/profile_info_widget.dart';
import 'package:lifeguard/widgets/profile-widgets/profile_redaction_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../api-services/image_service.dart';
import '../widgets/app-widgets/custom_button.dart';
import '../widgets/app-widgets/custom_textfield.dart';
import '../widgets/profile-widgets/profile_header_widget.dart';
import '../widgets/profile-widgets/my_info.dart';
import '../widgets/app-widgets/small_text.dart';
import 'package:lifeguard/widgets/app-widgets/transparent_button.dart';
import 'package:lifeguard/utils/permissions_manager.dart';

class StaffProfileScreen extends StatefulWidget {
  final int staffId;
  final Staff staff;

  StaffProfileScreen({required this.staffId, required this.staff});

  @override
  _StaffProfileScreenState createState() => _StaffProfileScreenState();
}

class _StaffProfileScreenState extends State<StaffProfileScreen>
    with SingleTickerProviderStateMixin {
  late Future<Staff> futureStaff;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isEditingVisible = false;
  final TextEditingController phone = TextEditingController();
  final TextEditingController vk = TextEditingController();
  final TextEditingController tg = TextEditingController();
  final TextEditingController mail = TextEditingController();
  final ShowStaffService _service = ShowStaffService();
  final PermissionsManager permissionsManager = PermissionsManager();

  List<Widget> allStaffWidgets = [];
  List<Widget> filteredStaffWidgets = [];

  @override
  void initState() {
    super.initState();
    futureStaff = _service.fetchStaffById(widget.staffId);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }


  void _toggleEditingWidget() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileRedactionWidget(staffId: widget.staffId, staff: widget.staff,)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудник'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<Staff>(
              future: futureStaff,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('Информация о пользователе не найдена'));
                } else {
                  final staff = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        FutureBuilder<Image>(
                          future: staff.avatar != null && staff.avatar.isNotEmpty
                              ? ImageService().fetchImage('user', staff.avatar)
                              : Future.error('No image available'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircleAvatar(radius: 50, child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return CircleAvatar(radius: 50, child: Icon(Icons.account_circle, size: 70));
                            } else {
                              return CircleAvatar(radius: 50, backgroundImage: snapshot.data?.image);
                            }
                          },
                        ),
                        ProfileHeaderWidget(
                          FirstName: staff.name,
                          SecondName: staff.surname,
                          Patronymic: staff.patronymic,
                        ),
                        MyInfo(
                          phone: staff.phone,
                          VK_Link: staff.vk,
                          TG_Link: staff.tg,
                          Mail_Link: staff.email,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: 1170
              ),
              width: double.infinity,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorScheme.of(context).primary
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('  Личное дело', style: TextTheme.of(context).bodyMedium),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.link))
                ],
              ),
            ),
            Spacer(),
            FutureBuilder<bool>(
              future: permissionsManager.hasPermission('user update'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error checking permissions');
                } else if (snapshot.hasData && snapshot.data!) {
                  return TextButton(
                      onPressed: _toggleEditingWidget,
                      child: Text('Редактировать данные сотруднкиа'));
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
