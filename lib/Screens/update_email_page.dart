import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizu/widgets/app_button.dart';
import '../logic/auth/error_code_handling.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_field.dart';

class UpdateEmail extends StatelessWidget {
  const UpdateEmail({super.key});

  get authService => null;

  @override
  Widget build(BuildContext context) {
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController newEmailController = TextEditingController();
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
      newEmailController.clear();
      confirmPasswordController.clear();
    }

    void updateEmail() async {
      if (user == null) {
        return;
      }
      try {
        final userCredential = EmailAuthProvider.credential(
          email: user.email ?? "",
          password: confirmPasswordController.text,
        );
        await user.reauthenticateWithCredential(userCredential);

        if (newEmailController.text.isNotEmpty) {
          await user.updateEmail(newEmailController.text);
          showSuccessSnackBar("Email updated successfully");
          clearControllers();
        } else {
          showSnackBar("New email cannot be empty");
        }
      } catch (e) {
        final errorMessage = ErrorCodeHandler.errorCodeDebug(e.toString());
        showSnackBar(errorMessage);
      }
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
                  controller: newEmailController,
                  hintText: "New email",
                  obscureText: false,
                ),
                SizedBox(
                  height: spacing,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(
                  height: spacing,
                ),
                AppButtons(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple[200]!,
                  borderColor: Colors.transparent,
                  text: "Update email",
                  width: double.infinity,
                  height: 65,
                  borderRadius: 10,
                  onPressed: () {
                    updateEmail();
                  },
                  fontSize: 0.03,
                ),
              ],
            ),
          ),
        ));
  }
}
