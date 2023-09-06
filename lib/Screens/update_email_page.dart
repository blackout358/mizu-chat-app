import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mizu/logic/account%20management/account_service.dart';
import 'package:mizu/widgets/app_button.dart';
import '../widgets/text_field.dart';

class UpdateEmail extends StatelessWidget {
  const UpdateEmail({super.key});

  get authService => null;

  @override
  Widget build(BuildContext context) {
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController newEmailController = TextEditingController();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    const double spacing = 15;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Change email"),
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
                const SizedBox(
                  height: spacing,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
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
                    AccountService.updateEmail(
                      user,
                      context,
                      confirmPasswordController,
                      newEmailController,
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
