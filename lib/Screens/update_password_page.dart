import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mizu/widgets/app_button.dart';

import 'package:mizu/widgets/text_field.dart';

import '../logic/account management/account_service.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  get authService => null;

  @override
  Widget build(BuildContext context) {
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmOldPasswordController =
        TextEditingController();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    const double spacing = 15;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Change password"),
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
                  controller: confirmOldPasswordController,
                  hintText: "Current password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: spacing,
                ),
                MyTextField(
                  controller: newPasswordController,
                  hintText: "New password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: spacing,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm new password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: spacing,
                ),
                AppButtons(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple[200]!,
                  borderColor: Colors.transparent,
                  text: "Update Password",
                  width: double.infinity,
                  height: 65,
                  borderRadius: 10,
                  onPressed: () {
                    AccountService.updatePassword(
                      user,
                      confirmPasswordController,
                      newPasswordController,
                      confirmOldPasswordController,
                      context,
                    );
                  },
                  fontSize: 0.03,
                ),
              ],
            ),
          ),
        ));
  }
}
