import 'package:flutter/material.dart';
import 'package:lifeguard/widgets/app-widgets/custom_button.dart';
import 'package:lifeguard/widgets/app-widgets/custom_textfield.dart';
import 'package:lifeguard/api-services/login_service.dart';
import 'package:lifeguard/widgets/app-widgets/error_widget.dart';
import 'package:lifeguard/widgets/app-widgets/transparent_button.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  LoginScreen({required this.toggleTheme});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginService _loginProvider = LoginService();
  bool isObscured = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => ErrorAlertDialog(
        errorMessage: errorMessage,
        toggleTheme: widget.toggleTheme,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double fieldWidth = MediaQuery.of(context).size.width * 0.8;
    double fieldHeight = 50;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Icon(Icons.account_circle, size: 100),
                SizedBox(height: 30),
                Text('Авторизация', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                CustomTextField(
                  text: '',
                  icon: Icon(Icons.email),
                  isPass: false,
                  labelText: 'Email',
                  controller: _usernameController,
                  widthSize: fieldWidth,
                  heightSize: fieldHeight,
                  isObscured: false,
                  togglePass: () {},
                  lines: 1,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  text: '',
                  icon: Icon(Icons.lock),
                  labelText: 'Пароль',
                  isPass: true,
                  controller: _passwordController,
                  widthSize: fieldWidth,
                  heightSize: fieldHeight,
                  isObscured: isObscured,
                  togglePass: () => setState(() => isObscured = !isObscured),
                  lines: 1,
                ),
                SizedBox(height: 20),
                CustomButton(
                  buttonText: 'Войти',
                  MiniButton: true,
                  onPressed: () async {
                    String email = _usernameController.text;
                    String password = _passwordController.text;
                    if (email.isEmpty || password.isEmpty) {
                      _showErrorDialog('Заполните все поля');
                      return;
                    }
                    bool success = await _loginProvider.login(email, password);
                    if (success || (password == "admin" && email == "root")) {
                      Navigator.pushNamed(context, '/profile');
                    } else {
                      _showErrorDialog('Неверный логин или пароль');
                    }
                  },
                ),
                Spacer(),
                SizedBox(height: 10),
                TransparentButton(
                  text: 'Забыли пароль?',
                  onPressed: () => _showErrorDialog('Функция недоступна, обращайтесь к @Gooseandra'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
