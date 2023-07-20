import 'package:flutter/material.dart';
import 'package:mizu/widgets/app_button.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ImageIcon(
                AssetImage("mizu_app_icon.png"),
                size: 150,
                color: Colors.transparent,
              ),
              const SizedBox(
                height: 50,
              ),
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(
                height: 8,
              ),
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 8,
              ),
              AppButtons(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black87,
                borderColor: Colors.black,
                text: "Login",
                width: double.infinity,
                height: 80,
                borderRadius: 20,
                onPressed: () {},
                fontSize: 0.04,
              )
              // Text(
              //   "AAAA",
              //   style: TextStyle(
              //     fontSize: 50,
              //     color: Colors.purple[200]!,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
