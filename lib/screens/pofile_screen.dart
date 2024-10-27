import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../models/user_model.dart';
import '../widgets/app-widgets/app_drawer.dart';
import '../widgets/app-widgets/custom_button.dart';
import '../widgets/app-widgets/custom_textfield.dart';
import '../widgets/app-widgets/error_widget.dart';
import '../widgets/profile-widgets/profile_header_widget.dart';
import '../widgets/profile-widgets/my_info.dart';
import '../widgets/app-widgets/small_text.dart';
import 'package:lifeguard/widgets/app-widgets/transparent_button.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  ProfileScreen({required this.toggleTheme});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin  {
  late Future<Map<String, dynamic>?> _userDataFuture;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isEditingVisible = false;
  final TextEditingController phone = TextEditingController();
  final TextEditingController vk = TextEditingController();
  final TextEditingController tg = TextEditingController();
  final TextEditingController mail = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userDataFuture = User().getUserData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  void _toggleEditingWidget() {
    setState(() {
      _isEditingVisible = !_isEditingVisible;
      if (_isEditingVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorAlertDialog(
          errorMessage: errorMessage,
          toggleTheme: widget.toggleTheme,
        );
      },
    );
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
        title: Text('Профиль'),
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Информация о пользователе не найдена'));
          } else {
            final userData = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 45),
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200')
                  ),
                  ProfileHeaderWidget(
                    FirstName: userData['name'],
                    SecondName: userData['surname'],
                    Patronymic: userData['patronymic'],
                    //Post1: userData['rank'],
                  ),
                  SizedBox(height: 30),
                  SizedBox(height: 10),
                  SmallText(some_text: 'Личные данные', Width: MediaQuery.of(context).size.width * 0.9,),
                  MyInfo(
                    phone: userData['phone'],
                    VK_Link: userData['vk'],
                    TG_Link: userData['tg'],
                    Mail_Link: userData['email'],
                  ),
                  SizedBox(height: 10),
                  ResponsiveBuilder(
                     builder: (context, sizingInformation) {
                       double width;
                       if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
                         width = MediaQuery.of(context).size.width * 0.85;
                       } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                         width = MediaQuery.of(context).size.width * 0.65;
                       } else {
                         width = MediaQuery.of(context).size.width * 0.5;
                       }
                       return SlideTransition(
                           position: Tween<Offset>(
                             begin: Offset(0, 1),
                             end: Offset(0, 0),
                           ).animate(_controller),
                           child: _isEditingVisible ? Container(
                            child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 SizedBox(height: 20,),
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
                                       setState(() { isObscured = isObscured; });
                                     }), SizedBox(height: 20,),
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
                                       setState(() { isObscured = isObscured; });
                                     }), SizedBox(height: 20,),
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
                                       setState(() { isObscured = isObscured; });
                                     }), SizedBox(height: 20,),
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
                                       setState(() { isObscured = isObscured; });
                                     }),
                                 SizedBox(height: 25),
                                 CustomButton(
                                   buttonText: 'Сохранить',
                                   MiniButton: true,
                                   onPressed: () {
                                     print('${phone.text}, ${vk.text}, ${tg.text}, ${mail.text}');
                                     _showErrorDialog('Данные отправлены');
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
                           ) : SizedBox.shrink()
                       );
                     }
                     ),
                  SizedBox(height: 10),
                  TransparentButton(
                    text: 'Редактировать личные данные',
                    onPressed: _toggleEditingWidget,
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

