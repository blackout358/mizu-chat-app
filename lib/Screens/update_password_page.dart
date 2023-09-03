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

    void showSnackBar(String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          text: text,
          textColour: Colors.black,
          height: 30,
          duration: 2,
          fontSize: 20,
          backgroundColor: Colors.purple[200]!,
        ),
      );
    }

    void showSuccessSnackBar(String text) {
      showSnackBar(text);
    }

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
            showSuccessSnackBar("Password updated successfully");
            clearControllers();
          } else {
            showSnackBar("New password cannot be empty");
          }
        } else {
          showSnackBar("Passwords do not match");
        }
      } catch (e) {
        final errorMessage = ErrorCodeHandler.errorCodeDebug(e.toString());
        showSnackBar(errorMessage);
      }
    }

    // void updatePassword() async {
    //   try {
    //     if (user != null) {
    //       final userCredential = EmailAuthProvider.credential(
    //         email: user.email ?? "",
    //         password: confirmOldPasswordController.text,
    //       );

    //       try {
    //         await user.reauthenticateWithCredential(userCredential);

    //         // Check if the new password is not empty
    //         final newPassword = newPasswordController.text;
    //         if (newPasswordController.text == confirmPasswordController.text) {
    //           if (newPassword.isNotEmpty) {
    //             await user.updatePassword(newPassword);
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               CustomSnackBar(
    //                 text: "Password updated successfully",
    //                 textColour: Colors.black,
    //                 height: 30,
    //                 duration: 2,
    //                 fontSize: 20,
    //                 backgroundColor: Colors.purple[200]!,
    //               ),
    //             );
    //             newPasswordController.clear();
    //             confirmPasswordController.clear();
    //             confirmOldPasswordController.clear();
    //           } else {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               CustomSnackBar(
    //                 text: "New password cannot be empty",
    //                 textColour: Colors.black,
    //                 height: 30,
    //                 duration: 2,
    //                 fontSize: 20,
    //                 backgroundColor: Colors.purple[200]!,
    //               ),
    //             );
    //           }
    //         } else {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             CustomSnackBar(
    //               text: "Passwords do not match",
    //               textColour: Colors.black,
    //               height: 30,
    //               duration: 2,
    //               fontSize: 20,
    //               backgroundColor: Colors.purple[200]!,
    //             ),
    //           );
    //         }
    //       } catch (e) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           CustomSnackBar(
    //             text: ErrorCodeHandler.errorCodeDebug(e.toString()),
    //             textColour: Colors.black,
    //             height: 30,
    //             duration: 2,
    //             fontSize: 20,
    //             backgroundColor: Colors.purple[200]!,
    //           ),
    //         );
    //       }
    //     }
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       CustomSnackBar(
    //         text: ErrorCodeHandler.errorCodeDebug(e.toString()),
    //         textColour: Colors.black,
    //         height: 30,
    //         duration: 2,
    //         fontSize: 20,
    //         backgroundColor: Colors.purple[200]!,
    //       ),
    //     );
    //   }
    // }

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
