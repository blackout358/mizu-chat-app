import 'package:mizu/Screens/register_page.dart';
import 'package:mizu/Screens/login_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onPressed: togglePages,
      );
    } else {
      return RegisterPage(
        onPressed: togglePages,
      );
    }
  }
}
