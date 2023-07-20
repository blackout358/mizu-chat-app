import 'package:flutter/material.dart';
import 'package:mizu/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage("mizu_app_icon.png"),
              size: 90,
              color: Colors.transparent,
            ),
            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            Text(
              "AAAA",
              style: TextStyle(
                fontSize: 50,
                color: Colors.purple[200]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
