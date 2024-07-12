import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_textfield.dart';
import 'package:lifeguard/api-services/login_service.dart';
import 'package:lifeguard/widgets/app-widgets/error_widget.dart';

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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              isPass: false,
              text: 'Email',
              controller: _usernameController,
            ),
            SizedBox(height: 20),
            CustomTextField(
              isPass: true,
              text: 'Пароль',
              controller: _passwordController,
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
            )
          ],
        ),
      ),
    );
  }
}
