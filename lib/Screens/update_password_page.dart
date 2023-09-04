import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizu/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../logic/auth/auth_service.dart';
import '../logic/auth/error_code_handling.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_field.dart';

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
    final authService = Provider.of<AuthService>(context, listen: false);
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final user = _firebaseAuth.currentUser;
    const double spacing = 15;

    void clearControllers() {
      newPasswordController.clear();
      confirmPasswordController.clear();
      confirmOldPasswordController.clear();
    }

    void updatePassword() async {
      if (user == null) {
        return;
      }
      try {
        final userCredential = EmailAuthProvider.credential(
          email: user.email ?? "",
          password: confirmOldPasswordController.text,
        );
        await user.reauthenticateWithCredential(userCredential);

        if (newPasswordController.text == confirmPasswordController.text) {
          if (newPasswordController.text.isNotEmpty) {
            await user.updatePassword(newPasswordController.text);
            if (context.mounted) {
              CustomSnackBar.snackBarOne(
                  "Password updated successfully", context);
            }
            clearControllers();
          } else {
            if (context.mounted) {
              CustomSnackBar.snackBarOne(
                  "New password cannot be empty", context);
            }
          }
        } else {
          if (context.mounted) {
            CustomSnackBar.snackBarOne("Passwords do not match", context);
          }
        }
      } catch (e) {
        final errorMessage = ErrorCodeHandler.errorCodeDebug(e.toString());
        CustomSnackBar.snackBarOne(errorMessage, context);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Change password"),
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
                SizedBox(
                  height: spacing,
                ),
                MyTextField(
                  controller: newPasswordController,
                  hintText: "New password",
                  obscureText: true,
                ),
                SizedBox(
                  height: spacing,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm new password",
                  obscureText: true,
                ),
                SizedBox(
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
                    updatePassword();
                  },
                  fontSize: 0.03,
                ),
              ],
            ),
          ),
        ));
  }
}
