import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_textfield.dart';
import 'package:lifeguard/api-services/login_service.dart';
import 'package:lifeguard/widgets/app-widgets/error_widget.dart';
import 'package:lifeguard/widgets/transparent_button.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  LoginScreen({required this.toggleTheme});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController unUsable = TextEditingController();
  final LoginService _loginProvider = LoginService();


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20,20,20,0),
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://sun1-17.userapi.com/s/v1/ig2/5oQd1HwXQjdP9Tmj1Apbc4g7MTfT6LmeMW99acU-htKmjxidJ9t0aldZ7hD-P_9L5ZlLwrzEIMwPre0w6-V1BMg1.jpg?quality=95&crop=1,0,834,834&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720&ava=1&u=aseTjjK2s91iQeI5LbaqLOf6Kcm40eYRe6SBVTsbT6k&cs=200x200'),
            ),
            SizedBox( height: 50,),
            Text ('Авторизация', style: TextStyle (fontSize: 18),),
            SizedBox( height: 30,),
            ResponsiveBuilder(builder:
            (context, sizingInformation) {
              if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
                return CustomTextField(
                  isPass: false,
                  widthSize: MediaQuery.of(context).size.width * 0.65,
                  labelText: 'Email',
                  text: '',
                  controller: _usernameController,
                );
            } else if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                return CustomTextField(
                  isPass: false,
                  widthSize: MediaQuery.of(context).size.width * 0.25,
                  labelText: 'Email',
                  text: '',
                  controller: _usernameController,
                );}
              return Container();},
            ),
            SizedBox(height: 15),
            ResponsiveBuilder(builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
                return CustomTextField(
                  labelText: 'Пароль',
                  widthSize: MediaQuery.of(context).size.width * 0.65,
                  isPass: true,
                  text: '',
                  controller: _passwordController,
                );
              } else if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
                return CustomTextField(
                  labelText: 'Пароль',
                  widthSize: MediaQuery.of(context).size.width * 0.25,
                  isPass: true,
                  text: '',
                  controller: _passwordController,
                );}
              return Container();},
            ),
            SizedBox(height: 40),
            CustomButton(
              buttonText: 'Войти',
              MiniButton: true,
              onPressed: () async {
                String email = _usernameController.text;
                String password = _passwordController.text;
                bool success = await _loginProvider.login(email, password);
                if (success) {
                  Navigator.pushNamed(context, '/profile');
                } else {
                  _showErrorDialog('Неверный логин или пароль \n Обратитесь к администору');
                }
              },
            ),


               TransparentButton(text: 'Забыли пароль?', onPressed: () {
                    print('Реально забыал');
                  }),


            ]
            )
        ),
      );

  }
}
