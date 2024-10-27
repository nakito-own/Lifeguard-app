import 'package:flutter/material.dart';
import 'package:lifeguard/api-services/show_staff_service.dart';
import 'package:lifeguard/widgets/profile-widgets/profile_header_widget.dart';
import 'package:lifeguard/widgets/profile-widgets/profile_info_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../models/staff_model.dart';
import '../app-widgets/custom_button.dart';
import '../app-widgets/custom_textfield.dart';
import '../app-widgets/custom_redaction_button.dart';
import '../app-widgets/small_text.dart';
import 'package:lifeguard/utils/permissions_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileRedactionWidget extends StatefulWidget {
  final int staffId;
  Staff staff;

  ProfileRedactionWidget({required this.staffId, required this.staff});

  @override
  _ProfileRedactionWidgetState createState() => _ProfileRedactionWidgetState();
}

class _ProfileRedactionWidgetState extends State<ProfileRedactionWidget>
    with SingleTickerProviderStateMixin {
  late Future<Staff> futureStaff;
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController phone = TextEditingController();
  final TextEditingController vk = TextEditingController();
  final TextEditingController tg = TextEditingController();
  final TextEditingController mail = TextEditingController();
  final ShowStaffService _service = ShowStaffService();
  final PermissionsManager permissionsManager = PermissionsManager();

  bool _isEditingVisible = false;

  late final TextEditingController _Namecontroller;
  late final TextEditingController _Surnamecontroller;
  late final TextEditingController _Patronymiccontroller;


  List<Widget> allStaffWidgets = [];
  List<Widget> filteredStaffWidgets = [];

  @override
  void initState() {
    super.initState();
    _Namecontroller = TextEditingController(text: widget.staff.name);
    _Surnamecontroller = TextEditingController(text: widget.staff.surname);
    _Patronymiccontroller = TextEditingController(text: widget.staff.patronymic);
    futureStaff = _service.fetchStaffById(widget.staffId);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }


  void _EditingWidget() {
   Navigator.pop(context);
  }

  /*void _toggleEditPerson() {
    setState(() {
      _isEditingVisible = !_isEditingVisible;
      if (_isEditingVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }*/



  void _EditPerson() {
    setState(() {
      widget.staff = widget.staff.copyWith(
        newName: _Namecontroller.text,
        newSurname: _Surnamecontroller.text,
        newPatronymic: _Patronymiccontroller.text,
      );
    });

    print('Updated Staff: ${widget.staff.toJson()}');

    sendDataToServer();
  }


  Future<void> sendDataToServer() async {
    final prefs = await SharedPreferences.getInstance();
    final String url = 'http://95.163.221.72:8000/users';
    final String? token = prefs.getString('jwt');


    final Map<String, dynamic> data = {
      'name': widget.staff.name,
      'surname': widget.staff.surname,
      'patronymic': widget.staff.patronymic,

    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'JWT': '$token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Данные успешно отправлены: ${response.body}');
      } else {
        print('Ошибка при отправке данных: ${response.statusCode}');
        print('Новые данные: ${jsonEncode(data)}');
      }
    } catch (e) {
      print('Произошла ошибка: $e');
    }
  }


  @override
  void dispose() {
    _Namecontroller.dispose();
    _Surnamecontroller.dispose();
    _Patronymiccontroller.dispose();
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
                  SizedBox(height: 15),
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200')),
                  SizedBox(height: 10),
                  ProfileHeaderWidget(
                    FirstName: staff.name,
                    SecondName: staff.surname,
                    Patronymic: staff.patronymic,
                  ),
                  CustomTextField(
                      text: '',
                      lines: 1,
                      labelText: 'Имя',
                      widthSize: 300,
                      heightSize: 42,
                      icon: Icon(Icons.ac_unit),
                      controller: _Namecontroller,
                      isObscured: isObscured,
                      togglePass: () {
                        setState(() {
                          isObscured = isObscured;
                        });
                      }), SizedBox(height: 20),
                  CustomTextField(
                      text: '',
                      lines: 1,
                      labelText: 'Фамилия',
                      widthSize: 300,
                      heightSize: 42,
                      icon: Icon(Icons.ac_unit),
                      controller: _Surnamecontroller,
                      isObscured: isObscured,
                      togglePass: () {
                        setState(() {
                          isObscured = isObscured;
                        });
                      }), SizedBox(height: 20),
                  CustomTextField(
                      text: '',
                      lines: 1,
                      labelText: 'Отчество',
                      widthSize: 300,
                      heightSize: 42,
                      icon: Icon(Icons.ac_unit),
                      controller:_Patronymiccontroller,
                      isObscured: isObscured,
                      togglePass: () {
                        setState(() {
                          isObscured = isObscured;
                        });
                      }), SizedBox(height: 10),
                  CustomRedactionButton(
                    redactionText: 'Изменить ФИО',
                    onPressed: _EditPerson,
                  ),
                  SizedBox(height: 30),
                  Row( children: [
                  SmallText(some_text: 'Основная информация', Width: 200,),
                  ],),
                  SizedBox(height: 10),
                  ProfileInfoWidget(),
                  Row( children: [
                  SmallText(some_text: 'Личные данные', Width: 200,),
                  ],),

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
                    return Container(
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
                                  _EditingWidget();
                                  phone.clear();
                                  vk.clear();
                                  tg.clear();
                                 mail.clear();
                                },
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
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
                        return Text('');
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
