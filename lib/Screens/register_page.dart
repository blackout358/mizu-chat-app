import 'package:flutter/material.dart';
import 'package:mizu/logic/auth/auth_service.dart';
import 'package:mizu/widgets/app_button.dart';
import 'package:mizu/widgets/snackbar.dart';
import 'package:mizu/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../logic/auth/error_code_handling.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onPressed;
  const RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      CustomSnackBar.snackBarOne(
        "Passwords do not match!",
        context,
      );

      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      CustomSnackBar.snackBarOne(
        ErrorCodeHandler.errorCodeDebug(e.toString()),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/mizu_app_icon.png",
                  width: 150,
                  height: 150,
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
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                AppButtons(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
                  borderColor: Colors.transparent,
                  text: "Sign Up",
                  width: double.infinity,
                  height: 65,
                  borderRadius: 20,
                  onPressed: () {
                    signUp();
                  },
                  fontSize: 0.04,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onPressed,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
