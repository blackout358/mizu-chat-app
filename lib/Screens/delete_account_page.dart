import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_field.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final user = _firebaseAuth.currentUser;
    const double spacing = 15;

    void clearControllers() {
      confirmPasswordController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Change email"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              SizedBox(
                height: spacing,
              ),
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              SizedBox(
                height: spacing,
              ),
              MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm password",
                obscureText: true,
              ),
              SizedBox(
                height: spacing,
              ),
              AppButtons(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple[200]!,
                borderColor: Colors.transparent,
                text: "Delete account",
                width: double.infinity,
                height: 65,
                borderRadius: 10,
                onPressed: () {},
                fontSize: 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
