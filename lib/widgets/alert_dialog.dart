import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String dialogText;
  final VoidCallback onPressed;
  const MyAlertDialog(
      {super.key, required this.dialogText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogText),
    );
  }
}
