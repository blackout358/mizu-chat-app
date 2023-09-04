import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizu/widgets/app_button.dart';
import 'package:provider/provider.dart';

import 'package:mizu/logic/auth/auth_service.dart';
import 'package:mizu/logic/auth/error_code_handling.dart';
import 'package:mizu/widgets/snackbar.dart';
import 'package:mizu/widgets/text_field.dart';

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
}