import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String dialogTitle;
  final String dialogText;
  final VoidCallback onPressed;
  MyAlertDialog(
      {super.key,
      required this.dialogText,
      required this.onPressed,
      required this.dialogTitle});

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text("Cancel"),
    );

    Widget confirmButton = TextButton(
      onPressed: () {
        onPressed();
        Navigator.of(context).pop();
      },
      child: Text("Confirm"),
    );

    return AlertDialog(
      title: Text(dialogTitle),
      content: Text(dialogText),
      actions: [cancelButton, confirmButton],
    );
  }
}
