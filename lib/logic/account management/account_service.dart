import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mizu/logic/auth/error_code_handling.dart';
import 'package:mizu/widgets/snackbar.dart';

import '../../widgets/deletion_alert_dialog.dart';

class AccountService {
  static void updatePassword(
    User? user,
    TextEditingController confirmPasswordController,
    TextEditingController newPasswordController,
    TextEditingController confirmOldPasswordController,
    BuildContext context,
  ) async {
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
          newPasswordController.clear();
          confirmPasswordController.clear();
          confirmOldPasswordController.clear();
        } else {
          if (context.mounted) {
            CustomSnackBar.snackBarOne("New password cannot be empty", context);
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

  static void updateEmail(
    User? user,
    BuildContext context,
    TextEditingController confirmPasswordController,
    TextEditingController newEmailController,
  ) async {
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

        if (context.mounted) {
          CustomSnackBar.snackBarOne("Email updated successfully", context);
        }

        newEmailController.clear();
        confirmPasswordController.clear();
      } else {
        if (context.mounted) {
          CustomSnackBar.snackBarOne("New email cannot be empty", context);
        }
      }
    } catch (e) {
      final errorMessage = ErrorCodeHandler.errorCodeDebug(e.toString());
      CustomSnackBar.snackBarOne(errorMessage, context);
    }
  }

  static void deleteAccount(
    BuildContext context,
    User? user,
    TextEditingController confirmPasswordController,
    TextEditingController passwordController,
    TextEditingController confirmController,
  ) async {
    if (user == null) {
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      CustomSnackBar.snackBarOne("Passwords are not the same", context);
      return;
    }
    try {
      final userCredential = EmailAuthProvider.credential(
        email: user.email ?? "",
        password: confirmPasswordController.text,
      );
      await user.reauthenticateWithCredential(userCredential);
      if (context.mounted) {
        showDialog(
          context: context,
          builder: ((context) {
            return MyDeletionDialog(
              dialogText: "",
              dialogTitle: "Delete Confirmation",
              confirmController: confirmController,
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .delete();
                user.delete();
              },
            );
          }),
        );
      }
    } catch (e) {
      final errorMessage = ErrorCodeHandler.errorCodeDebug(e.toString());
      CustomSnackBar.snackBarOne(errorMessage, context);
    }
  }
}
