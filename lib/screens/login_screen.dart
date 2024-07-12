import 'package:flutter/material.dart';
import 'package:lifeguard/providers/login_provider.dart';
import 'package:lifeguard/widgets/custom_button.dart';
import 'package:lifeguard/widgets/custom_textfield.dart';
import 'package:lifeguard/providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  LoginScreen({required this.toggleTheme});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final LoginProvider _loginProvider = LoginProvider();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  // Здесь можно добавить обработку ошибки
                  print('Login failed');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
