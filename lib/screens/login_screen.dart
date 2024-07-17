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
            Icon(
              Icons.account_circle,
              size: 100,
            ),
            SizedBox( height: 40,),
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
                  _showErrorDialog('Неверный логин или пароль');
                }
              },
            ),
               TransparentButton(text: 'Забыли пароль?', onPressed: () {
                 _showErrorDialog('Функция недоступна, обращайтесь к @Gooseandra');
                    print('Реально забыал');
                  }),
            ]
            )
        ),
      );

  }
}
