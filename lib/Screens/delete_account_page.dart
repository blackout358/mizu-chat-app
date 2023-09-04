import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizu/logic/auth/error_code_handling.dart';
import 'package:mizu/widgets/alert_dialog.dart';
import 'package:mizu/widgets/deletion_alert_dialog.dart';

import '../widgets/app_button.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_field.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController confirmController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final user = _firebaseAuth.currentUser;
    const double spacing = 15;
    final _formKey = GlobalKey<FormState>();
    bool enableButton = true;

    void clearControllers() {
      confirmPasswordController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    }

    void checkConfirm() {
      if (confirmController.text == "CONFIRM") {
        enableButton = true;
      } else {
        enableButton = false;
      }
    }

    void deleteAccount(BuildContext context) async {
      if (user == null) {
        return;
      }
      try {
        // final userCredential = EmailAuthProvider.credential(
        //   email: user.email ?? "",
        //   password: confirmPasswordController.text,
        // );
        // await user.reauthenticateWithCredential(userCredential);
        if (context.mounted) {
          showDialog(
            context: context,
            builder: ((context) {
              return MyDeletionDialog(
                dialogText: "",
                checkEnable: enableButton,
                dialogTitle: "Delete Confirmation",
                confirmController: confirmController,
                onPressed: () {
                  print("Deleted");
                },
                onChange: checkConfirm,
              );
            }),
          );
        }
      } catch (e) {
        final errorMessage = ErrorCodeHandler.errorCodeDebug(e.toString());
        CustomSnackBar.snackBarOne(errorMessage, context);
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
                onPressed: () {
                  deleteAccount(context);
                },
                fontSize: 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
