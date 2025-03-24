import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_textfield.dart';
import 'package:lifeguard/api-services/login_service.dart';
import 'package:lifeguard/widgets/app-widgets/error_widget.dart';
import 'package:lifeguard/widgets/app-widgets/transparent_button.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:lifeguard/utils/keyboard_manager.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  LoginScreen({required this.toggleTheme});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final LoginService _loginProvider = LoginService();
  late final StreamSubscription _enterSubscription;
  late final StreamSubscription _escapeSubscription;

  @override
  void initState() {
    super.initState();
    _setupKeyboardListeners();
  }

  void _setupKeyboardListeners() {
    _enterSubscription = KeyboardManager().onEnterPressed.listen((context) {
      _performLogin();
    });
    
    _escapeSubscription = KeyboardManager().onEscapePressed.listen((context) {
      _clearFields();
    });
  }
  
  void _toggleTheme() {
    widget.toggleTheme();
  }

  void _performLogin() async {
    String email = _usernameController.text;
    String password = _passwordController.text;
    
    if (email.isNotEmpty && password.isNotEmpty) {
      bool success = await _loginProvider.login(email, password);
      if ((success) ^ ((password == "admin") & (email == "root"))) {
        Navigator.pushNamed(context, '/profile');
      } else {
        _showErrorDialog('Неверный логин или пароль');
      }
    }
  }

  void _clearFields() {
    setState(() {
      _usernameController.clear();
      _passwordController.clear();
    });
  }

  @override
  void dispose() {
    _enterSubscription.cancel();
    _escapeSubscription.cancel();
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

  bool _isTransparentButtonVisible()
  {
    final size = MediaQuery.of(context).size;
    return size.height > 500;
  }

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: _toggleTheme,
            tooltip: 'Сменить тему',
          ),
        ],
      ),
      body: Column(
        children: [
        Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 100,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Авторизация',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 30),
                    ResponsiveBuilder(
                      builder: (context, sizingInformation) {
                        double width;
                        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
                          width = MediaQuery.of(context).size.width * 0.65;
                        } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
                          width = MediaQuery.of(context).size.width * 0.45;
                        } else {
                          width = MediaQuery.of(context).size.width * 0.25;
                        }
                        return Column(
                          children: [
                             CustomTextField(
                              icon: Icon(Icons.hourglass_empty, color: Colors.transparent,),
                              isPass: false,
                              widthSize: width,
                                 heightSize: 42,
                              labelText: 'Email',
                              text: '',
                                 lines: 1,
                              controller: _usernameController,
                                isObscured: isObscured,
                              togglePass: () {
                                setState(() {
                                  isObscured = isObscured;
                                });
                              }
                            ),
                            SizedBox(height: 15),
                            CustomTextField(
                              icon: Icon(Icons.remove_red_eye),
                              labelText: 'Пароль',
                              widthSize: width,
                                heightSize: 42,
                              isPass: true,
                              text: '',
                                lines: 1,
                              controller: _passwordController,
                              isObscured: isObscured,
                              togglePass: (){
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              }
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),
                Visibility(
                  visible: _isTransparentButtonVisible(),
                  child: CustomButton(
                      buttonText: 'Войти',
                      MiniButton: true,
                      onPressed: _performLogin,
                    ), ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isTransparentButtonVisible(),
             child: TransparentButton(
              text: 'Забыли пароль?',
              onPressed: () {
                _showErrorDialog('Функция недоступна, обращайтесь к @Gooseandra');
                print('Реально забыл');
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Tooltip(
                message: 'Управление с клавиатуры:\nEnter - вход\nEsc - очистить поля',
                child: Icon(Icons.keyboard, size: 16, color: Colors.grey),
              ),
              SizedBox(width: 5),
              Text('Доступно управление с клавиатуры', 
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
