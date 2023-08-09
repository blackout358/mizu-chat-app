import 'package:flutter/material.dart';
import 'package:mizu/logic/auth/auth_service.dart';
import 'package:mizu/widgets/app_button.dart';
import 'package:mizu/widgets/snackbar.dart';
import 'package:mizu/widgets/text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      print(e.toString());
      if (e == 'auth/wrong-password') {
        CustomSnackBar(
            text: "Incorrect password",
            textColour: Colors.black,
            height: 30,
            duration: 2,
            fontSize: 20,
            backgroundColor: Colors.purple[200]!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
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
                  // color: Colors.transparent,
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
                  obscureText: false,
                ),
                const SizedBox(
                  height: 8,
                ),
                AppButtons(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
                  borderColor: Colors.transparent,
                  text: "Login",
                  width: double.infinity,
                  height: 65,
                  borderRadius: 20,
                  onPressed: () {
                    signIn();
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
                      child: const Text("Register now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
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
      ),
    );
  }
}
