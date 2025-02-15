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
      body: FutureBuilder<Staff>(
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
                  SizedBox(height: 45),
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
                  SizedBox(height: 30),
                  Row( children: [
                    SmallText(some_text: 'Личные данные', Width: MediaQuery.of(context).size.width * 0.9,),
                  ],),
                  MyInfo(
                    phone: staff.phone,
                    VK_Link: staff.vk,
                    TG_Link: staff.tg,
                    Mail_Link: staff.email,
                  ),
                  SizedBox(height: 10),
                  ResponsiveBuilder(builder: (context, sizingInformation) {
                    double width;
                    if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.mobile) {
                      width = MediaQuery.of(context).size.width * 0.85;
                    } else if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.tablet) {
                      width = MediaQuery.of(context).size.width * 0.65;
                    } else {
                      width = MediaQuery.of(context).size.width * 0.5;
                    }
                    return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, 1),
                          end: Offset(0, 0),
                        ).animate(_controller),
                        child: _isEditingVisible
                            ? Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 20),
                              CustomTextField(
                                  text: '+7 999 999 99 99',
                                  lines: 1,
                                  labelText: 'Телефон',
                                  widthSize: width,
                                  heightSize: 42,
                                  icon: Icon(Icons.ac_unit),
                                  controller: phone,
                                  isObscured: isObscured,
                                  togglePass: () {
                                    setState(() {
                                      isObscured = isObscured;
                                    });
                                  }),
                              SizedBox(height: 20),
                              CustomTextField(
                                  text: 'https://vk.com/',
                                  lines: 1,
                                  labelText: 'VK',
                                  widthSize: width,
                                  heightSize: 42,
                                  icon: Icon(Icons.ac_unit),
                                  controller: vk,
                                  isObscured: isObscured,
                                  togglePass: () {
                                    setState(() {
                                      isObscured = isObscured;
                                    });
                                  }),
                              SizedBox(height: 20),
                              CustomTextField(
                                  text: 'https://t.me/',
                                  lines: 1,
                                  labelText: 'TG',
                                  widthSize: width,
                                  heightSize: 42,
                                  icon: Icon(Icons.ac_unit),
                                  controller: tg,
                                  isObscured: isObscured,
                                  togglePass: () {
                                    setState(() {
                                      isObscured = isObscured;
                                    });
                                  }),
                              SizedBox(height: 20),
                              CustomTextField(
                                  text: 'https://mail.ru/',
                                  lines: 1,
                                  labelText: 'Почта',
                                  widthSize: width,
                                  heightSize: 42,
                                  icon: Icon(Icons.ac_unit),
                                  controller: mail,
                                  isObscured: isObscured,
                                  togglePass: () {
                                    setState(() {
                                      isObscured = isObscured;
                                    });
                                  }),
                              SizedBox(height: 25),
                              CustomButton(
                                buttonText: 'Сохранить',
                                MiniButton: true,
                                onPressed: () {
                                  print(
                                      '${phone.text}, ${vk.text}, ${tg.text}, ${mail.text}');
                                  _toggleEditingWidget();
                                  phone.clear();
                                  vk.clear();
                                  tg.clear();
                                  mail.clear();
                                },
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        )
                            : SizedBox.shrink());
                  }),
                  SizedBox(height: 10),
                  FutureBuilder<bool>(
                    future: permissionsManager.hasPermission('user update'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error checking permissions');
                      } else if (snapshot.hasData && snapshot.data!) {
                        return TransparentButton(
                          text: 'Редактировать данные сотрудника',
                          onPressed: _toggleEditingWidget
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
